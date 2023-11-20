import 'package:bloc/bloc.dart';
import 'package:book_store/core/constant/firebase_collections.dart';
import 'package:book_store/utils/convert.dart';
import 'package:book_store/utils/phone_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'init_profile_event.dart';
part 'init_profile_state.dart';

class InitProfileBloc extends Bloc<InitProfileEvent, InitProfileState> {
  InitProfileBloc() : super(const InitProfileState()) {
    on<UpdateNameEvent>(_onUpdateName);
    on<UpdatePhoneEvent>(_onUpdatePhone);
    on<UpdateBirthdayEvent>(_onUpdateBirthday);
    on<UpdateGenderEvent>(_onUpdateGender);
    on<SubmitEvent>(_onSubmit);
  }

  _onUpdateName(UpdateNameEvent event, Emitter emit) {
    emit(state.copyWith(name: event.name, errName: ""));
  }

  _onUpdatePhone(UpdatePhoneEvent event, Emitter emit) {
    emit(state.copyWith(phone: event.phone, errPhone: ""));
  }

  _onUpdateBirthday(UpdateBirthdayEvent event, Emitter emit) {
    emit(state.copyWith(birthday: event.birthday, errBirthday: ""));
  }

  _onUpdateGender(UpdateGenderEvent event, Emitter emit) {
    emit(state.copyWith(isMale: event.isMale));
  }

  _onSubmit(SubmitEvent event, Emitter emit) async {
    bool hasError = false;
    if (state.name.trim().isEmpty) {
      emit(state.copyWith(errName: "Vui lòng nhập tên"));
      hasError = true;
    }
    if (state.phone.trim().isEmpty ||
        !PhoneValidatorUtils.isValidVietnamesePhoneNumberNew(state.phone)) {
      emit(state.copyWith(errPhone: "Vui lòng nhập đúng số điện thoại"));
      hasError = true;
    }
    if (state.birthday == null) {
      emit(state.copyWith(errBirthday: "Vui lòng cung cấp ngày sinh"));
      hasError = true;
    }
    if (hasError) return;

    String uid = FirebaseAuth.instance.currentUser!.uid;
    String imgUrl = FirebaseAuth.instance.currentUser!.photoURL!;
    await FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(uid)
        .set(
      {
        'name': state.name,
        'phoneNumber': state.phone,
        'birthday': Converter.convertDateToStringWithoutTime(state.birthday!),
        'isMale': state.isMale,
        'avatar': imgUrl,
      },
      SetOptions(merge: true),
    );
  }
}
