import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'edit_pass_event.dart';
part 'edit_pass_state.dart';

class EditPasswordBloc extends Bloc<EditPasswordEvent, EditPasswordState> {
  EditPasswordBloc() : super(EditPasswordLoadingState()) {
    on<EditPasswordLoadingEvent>(loadingEvent);
    on<EditPasswordUpdateEvent>(changingEvent);
  }

  FutureOr<void> loadingEvent(
      EditPasswordLoadingEvent event, Emitter<EditPasswordState> emit) {
    emit(EditPasswordLoadingState());

    final userProviderData = FirebaseAuth.instance.currentUser!.providerData;

    if (userProviderData[0].providerId == 'password') {
      emit(
        const EditPassLoadingSuccessfulState(
          isLoading: false,
          isConfirmErr: false,
          confirmErrMsg: '',
        ),
      );
    } else if (userProviderData[0].providerId == 'google.com' ||
        userProviderData[0].providerId == 'facebook.com') {
      emit(EditPassGgFbState());
    }
  }

  FutureOr<void> changingEvent(
      EditPasswordUpdateEvent event, Emitter<EditPasswordState> emit) async {
    if (state is EditPassLoadingSuccessfulState) {
      if (event.newPass != event.confirmNewPass) {
        emit(
          const EditPassLoadingSuccessfulState(
            isLoading: false,
            isConfirmErr: true,
            confirmErrMsg: 'Xác nhận mật khẩu không khớp',
          ),
        );
      } else {
        emit(
          const EditPassLoadingSuccessfulState(
            isLoading: true,
            isConfirmErr: false,
            confirmErrMsg: '',
          ),
        );
        try {
          await FirebaseAuth.instance.currentUser!
              .updatePassword(event.newPass)
              .then((value) {
            emit(ChangePassSuccessfulState());

            Fluttertoast.showToast(msg: 'Thay đổi mật khẩu thành công');
          });
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            emit(
              const EditPassLoadingSuccessfulState(
                isLoading: false,
                isConfirmErr: true,
                confirmErrMsg: 'Mật khẩu không đủ mạnh',
              ),
            );
          }
          if (e.code == 'requires-recent-login') {
            emit(
              const EditPassLoadingSuccessfulState(
                isLoading: false,
                isConfirmErr: true,
                confirmErrMsg:
                    'Tài khoản của bạn đã được đăng nhập quá lâu. Vui lòng đăng nhập lại để có thể thay đổi mật khẩu.',
              ),
            );
          }
        }
      }
    }
  }
}
