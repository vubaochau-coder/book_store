import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:book_store/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserLoadingState()) {
    on<UserLoadingEvent>(userLoadingEvent);
    on<UserUpdateEvent>(userUpdateEvent);
  }

  FutureOr<void> userLoadingEvent(
      UserLoadingEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());

    try {
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
        final userDocRef =
            FirebaseFirestore.instance.collection('User').doc(uid);

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

        final transactionZero = await userDocRef
            .collection('Transaction')
            .where('status', isEqualTo: 0)
            .get();

        final transactionOne = await userDocRef
            .collection('Transaction')
            .where('status', isEqualTo: 1)
            .get();

        final transactionTwo = await userDocRef
            .collection('Transaction')
            .where('status', isEqualTo: 2)
            .get();

        final transactionThree = await userDocRef
            .collection('Transaction')
            .where('status', isEqualTo: 3)
            .get();

        add(UserUpdateEvent(
          countZero: transactionZero.size,
          countOne: transactionOne.size,
          countTwo: transactionTwo.size,
          countThree: transactionThree.size,
          model: model,
        ));
        // emit(
        //   UserLoadingSuccessfulState(userModel: model),
        // );
      });
    } on Exception catch (e) {
      emit(UserLoadingFailedState(error: e.toString()));
    }
  }

  FutureOr<void> userUpdateEvent(
      UserUpdateEvent event, Emitter<UserState> emit) {
    emit(UserLoadingSuccessfulState(
      zero: event.countZero,
      one: event.countOne,
      two: event.countTwo,
      three: event.countThree,
      userModel: event.model,
    ));
  }
}
