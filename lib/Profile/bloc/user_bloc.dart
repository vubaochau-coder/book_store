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

      final addressQuery =
          await FirebaseFirestore.instance.collection("User").doc(uid).get();
      if (addressQuery.exists) {
        if (addressQuery.data() != null) {
          if (addressQuery.data()!['address'] != null) {
            userAddress = List.from(addressQuery.get('address'));
          }
        }
      }
      UserModel model = UserModel(
          id: uid, name: name, imgUrl: photoURL, address: userAddress);

      emit(UserLoadingSuccessfulState(userModel: model));
    } on Exception catch (e) {
      emit(UserLoadingFailedState(error: e.toString()));
    }
  }
}
