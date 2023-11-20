import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:book_store/core/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/constant/firebase_collections.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  StreamSubscription? _userStream;

  UserBloc() : super(const UserState()) {
    on<UserLoadingEvent>(_onLoading);
    on<UserUpdateEvent>(_onUpdate);
    on<StreamTransactionEvent>(_onStreamTransaction);
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
    String uid = user.uid;

    final userQuery = await FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(uid)
        .get();

    String name = userQuery.data()!['name'];
    String photoURL = userQuery.data()!['avatar'];
    List<String> userAddress = [];

    if (userQuery.data()!['address'] != null) {
      userAddress = List.from(userQuery.get('address'));
    }
    UserModel model =
        UserModel(id: uid, name: name, imgUrl: photoURL, address: userAddress);

    emit(state.copyWith(
      userModel: model,
      isLoading: false,
    ));

    if (event.firstTime) {
      add(StreamTransactionEvent());
    }
    // String name = user.displayName!;
    // String photoURL = user.photoURL!;

    // FirebaseFirestore.instance
    //     .collection('User')
    //     .doc(uid)
    //     .collection('Transaction')
    //     .snapshots()
    //     .listen((event) async {
    //   final userDocRef = FirebaseFirestore.instance.collection('User').doc(uid);

    //   final addressQuery = await userDocRef.get();
    //   if (addressQuery.exists) {
    //     if (addressQuery.data() != null) {
    //       if (addressQuery.data()!['address'] != null) {
    //         userAddress = List.from(addressQuery.get('address'));
    //       }
    //     }
    //   }
    //   UserModel model = UserModel(
    //       id: uid, name: name, imgUrl: photoURL, address: userAddress);

    //   final futureGroup = await Future.wait([
    //     userDocRef
    //         .collection('Transaction')
    //         .where('status', isEqualTo: 0)
    //         .get(),
    //     userDocRef
    //         .collection('Transaction')
    //         .where('status', isEqualTo: 1)
    //         .get(),
    //     userDocRef
    //         .collection('Transaction')
    //         .where('status', isEqualTo: 2)
    //         .get(),
    //   ]);

    //   final transactionZero = futureGroup[0].size;
    //   final transactionOne = futureGroup[1].size;
    //   final transactionTwo = futureGroup[2].size;

    //   add(UserUpdateEvent(
    //     countZero: transactionZero,
    //     countOne: transactionOne,
    //     countTwo: transactionTwo,
    //     model: model,
    //   ));
    // });
  }

  _onUpdate(UserUpdateEvent event, Emitter emit) {
    emit(state.copyWith(
      zero: event.countZero,
      one: event.countOne,
      two: event.countTwo,
    ));
  }

  _onStreamTransaction(StreamTransactionEvent event, Emitter emit) async {
    final user = FirebaseAuth.instance.currentUser!;
    String uid = user.uid;

    _userStream?.cancel();
    _userStream = null;
    _userStream = FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(uid)
        .collection(FirebaseCollections.transaction)
        .snapshots()
        .listen((snapshotEvent) async {
      int transactionZero = 0;
      int transactionOne = 0;
      int transactionTwo = 0;

      for (var ele in snapshotEvent.docs) {
        if (int.parse(ele.get('status').toString()) == 0) {
          transactionZero++;
        }
        if (int.parse(ele.get('status').toString()) == 1) {
          transactionOne++;
        }
        if (int.parse(ele.get('status').toString()) == 2) {
          transactionTwo++;
        }
      }

      add(UserUpdateEvent(
        countZero: transactionZero,
        countOne: transactionOne,
        countTwo: transactionTwo,
      ));
    });
  }
}
