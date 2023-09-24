import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:book_store/core/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  StreamSubscription? _userStream;

  UserBloc() : super(const UserState()) {
    on<UserLoadingEvent>(_onLoading);
    on<UserUpdateEvent>(_onUpdate);
  }

  @override
  Future<void> close() async {
    _userStream?.cancel();
    _userStream = null;
    super.close();
  }

  _onLoading(UserLoadingEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    final user = FirebaseAuth.instance.currentUser!;

    List<String> userAddress = [];
    String uid = user.uid;
    String name = user.displayName!;
    String photoURL = user.photoURL!;

    FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Transaction')
        .snapshots()
        .listen((event) async {
      final userDocRef = FirebaseFirestore.instance.collection('User').doc(uid);

      final addressQuery = await userDocRef.get();
      if (addressQuery.exists) {
        if (addressQuery.data() != null) {
          if (addressQuery.data()!['address'] != null) {
            userAddress = List.from(addressQuery.get('address'));
          }
        }
      }
      UserModel model = UserModel(
          id: uid, name: name, imgUrl: photoURL, address: userAddress);

      final futureGroup = await Future.wait([
        userDocRef
            .collection('Transaction')
            .where('status', isEqualTo: 0)
            .get(),
        userDocRef
            .collection('Transaction')
            .where('status', isEqualTo: 1)
            .get(),
        userDocRef
            .collection('Transaction')
            .where('status', isEqualTo: 2)
            .get(),
      ]);

      final transactionZero = futureGroup[0].size;
      final transactionOne = futureGroup[1].size;
      final transactionTwo = futureGroup[2].size;

      add(UserUpdateEvent(
        countZero: transactionZero,
        countOne: transactionOne,
        countTwo: transactionTwo,
        model: model,
      ));
    });
  }

  _onUpdate(UserUpdateEvent event, Emitter emit) {
    emit(state.copyWith(
      isLoading: false,
      zero: event.countZero,
      one: event.countOne,
      two: event.countTwo,
      userModel: event.model,
    ));
  }
}
