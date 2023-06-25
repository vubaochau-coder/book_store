import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileLoadingState()) {
    on<EditProfileLoadingEvent>(editProfileLoadingEvent);
    on<EditProfileChangingEvent>(editProfileChangingEvent);
  }

  FutureOr<void> editProfileLoadingEvent(
      EditProfileLoadingEvent event, Emitter<EditProfileState> emit) async {
    if (state is! EditProfileLoadingSuccessfulState) {
      emit(EditProfileLoadingState());
    }

    String uid = FirebaseAuth.instance.currentUser!.uid;
    String photoURL = FirebaseAuth.instance.currentUser!.photoURL!;
    String displayName = FirebaseAuth.instance.currentUser!.displayName!;
    String phoneNumber = '';
    bool isMale = true;
    String birthday = '';

    //print("meta:" + FirebaseAuth.instance.currentUser!.providerData.toString());

    final userQuery =
        await FirebaseFirestore.instance.collection('User').doc(uid).get();

    if (userQuery.exists) {
      phoneNumber = (userQuery.data() as Map)['phoneNumber'] ?? '';
      isMale = (userQuery.data() as Map)['isMale'] ?? true;
      birthday = (userQuery.data() as Map)['birthday'] ?? '';
    }

    emit(EditProfileLoadingSuccessfulState(
      avtURL: photoURL,
      name: displayName,
      phone: phoneNumber,
      isMale: isMale,
      birthday: birthday,
      isLoading: false,
    ));
  }

  FutureOr<void> editProfileChangingEvent(
      EditProfileChangingEvent event, Emitter<EditProfileState> emit) async {
    if (state is EditProfileLoadingSuccessfulState) {
      final currentState = state as EditProfileLoadingSuccessfulState;

      emit(
        EditProfileLoadingSuccessfulState(
          avtURL: currentState.avtURL,
          name: currentState.name,
          phone: currentState.phone,
          isMale: currentState.isMale,
          birthday: currentState.birthday,
          isLoading: true,
        ),
      );

      String uid = FirebaseAuth.instance.currentUser!.uid;
      final currentUser = FirebaseAuth.instance.currentUser!;

      await currentUser.updateDisplayName(event.name);

      if (event.image != null) {
        final avatarImageRef = FirebaseStorage.instance
            .ref()
            .child("Avatar/${event.image!.path.split('/').last}");

        await avatarImageRef.putFile(event.image!).then((p0) async {
          String url = await p0.ref.getDownloadURL();

          await currentUser.updatePhotoURL(url);
        });
      }

      final userDoc = FirebaseFirestore.instance.collection('User').doc(uid);

      await userDoc.set({
        'phoneNumber': event.phone,
        'birthday': event.birthday,
        'isMale': event.gender,
      }, SetOptions(merge: true));

      Fluttertoast.showToast(msg: 'Cập nhật thông tin thành công');
      await Future.delayed(
        const Duration(seconds: 1),
        () {
          emit(EditProfileNavigateState());
        },
      );
    }
  }
}
