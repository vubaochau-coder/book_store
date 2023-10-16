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
  EditProfileBloc() : super(const EditProfileState()) {
    on<EditProfileLoadingEvent>(_onLoadingEvent);
    on<EditProfileChangingEvent>(_onChangingEvent);
    on<UpdateGenderEvent>(_onUpdateGender);
    on<UpdateBirthdayEvent>(_onUpdateBirthday);
    on<UpdatePhoneEvent>(_onUpdatePhone);
    on<UpdateNameEvent>(_onUpdateName);
    on<UpdateAvatarEvent>(_onUpdateAvatar);
  }

  _onLoadingEvent(EditProfileLoadingEvent event, Emitter emit) async {
    emit(const EditProfileState(isLoading: true));

    String uid = FirebaseAuth.instance.currentUser!.uid;
    String photoURL = FirebaseAuth.instance.currentUser!.photoURL!;
    String displayName = FirebaseAuth.instance.currentUser!.displayName!;
    String phoneNumber = '';
    bool isMale = true;
    String birthday = '';

    final userQuery =
        await FirebaseFirestore.instance.collection('User').doc(uid).get();

    if (userQuery.exists) {
      phoneNumber = (userQuery.data() as Map)['phoneNumber'] ?? '';
      isMale = (userQuery.data() as Map)['isMale'] ?? true;
      birthday = (userQuery.data() as Map)['birthday'] ?? '';
    }

    emit(state.copyWith(
      avtURL: photoURL,
      name: displayName,
      phone: phoneNumber,
      isMale: isMale,
      birthday: birthday,
      isLoading: false,
    ));
  }

  _onChangingEvent(EditProfileChangingEvent event, Emitter emit) async {
    emit(state.copyWith(showDialogLoading: true));

    bool haveError = false;

    if (state.name.trim().isEmpty || state.name.trim().length < 6) {
      emit(state.copyWith(isNameErr: true));
      haveError = true;
    }

    if (state.phone.trim().isEmpty || state.phone.trim().length < 10) {
      emit(state.copyWith(isPhoneErr: true));
      haveError = true;
    }

    if (state.birthday.trim().isEmpty) {
      emit(state.copyWith(isBirthdayErr: true));
      haveError = true;
    }

    if (haveError == false) {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      final currentUser = FirebaseAuth.instance.currentUser!;

      await currentUser.updateDisplayName(state.name.trim());

      if (state.newAvatar != null) {
        final avatarImageRef = FirebaseStorage.instance
            .ref()
            .child("Avatar/${state.newAvatar!.path.split('/').last}");

        await avatarImageRef.putFile(state.newAvatar!).then((p0) async {
          String url = await p0.ref.getDownloadURL();

          await currentUser.updatePhotoURL(url);
        });
      }

      final userDoc = FirebaseFirestore.instance.collection('User').doc(uid);

      await userDoc.set({
        'phoneNumber': state.phone.trim(),
        'birthday': state.birthday.trim(),
        'isMale': state.isMale,
      }, SetOptions(merge: true));

      Fluttertoast.showToast(msg: 'Cập nhật thông tin thành công');
      await Future.delayed(
        const Duration(seconds: 1),
        () {
          emit(EditProfileNavigateState());
        },
      );
    } else {
      emit(state.copyWith(showDialogLoading: false));
    }
  }

  _onUpdateGender(UpdateGenderEvent event, Emitter emit) {
    emit(state.copyWith(isMale: event.isMale));
  }

  _onUpdateBirthday(UpdateBirthdayEvent event, Emitter emit) {
    emit(state.copyWith(birthday: event.birthday));
  }

  _onUpdatePhone(UpdatePhoneEvent event, Emitter emit) {
    emit(state.copyWith(phone: event.phone));
  }

  _onUpdateName(UpdateNameEvent event, Emitter emit) {
    emit(state.copyWith(name: event.name));
  }

  _onUpdateAvatar(UpdateAvatarEvent event, Emitter emit) {
    emit(state.copyWith(newAvatar: event.avatar));
  }
}
