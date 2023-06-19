import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'change_pass_event.dart';
part 'change_pass_state.dart';

class ChangePassBloc extends Bloc<ChangePassEvent, ChangePassState> {
  ChangePassBloc() : super(ChangePassLoadingState()) {
    on<ChangePassLoadingEvent>(loadingEvent);
    on<ChangePassUpdatePassEvent>(changingEvent);
  }

  FutureOr<void> loadingEvent(
      ChangePassLoadingEvent event, Emitter<ChangePassState> emit) {
    emit(ChangePassLoadingState());

    final userProviderData = FirebaseAuth.instance.currentUser!.providerData;

    if (userProviderData[0].providerId == 'password') {
      emit(
        const ChangePassLoadingSuccessfulState(
          isLoading: false,
          isConfirmErr: false,
          confirmErrMsg: '',
        ),
      );
    } else if (userProviderData[0].providerId == 'google.com' ||
        userProviderData[0].providerId == 'facebook.com') {
      emit(ChangePassGgFbState());
    }
  }

  FutureOr<void> changingEvent(
      ChangePassUpdatePassEvent event, Emitter<ChangePassState> emit) async {
    if (state is ChangePassLoadingSuccessfulState) {
      if (event.newPass != event.confirmNewPass) {
        emit(
          const ChangePassLoadingSuccessfulState(
            isLoading: false,
            isConfirmErr: true,
            confirmErrMsg: 'Xác nhận mật khẩu không khớp',
          ),
        );
      } else {
        emit(
          const ChangePassLoadingSuccessfulState(
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
              const ChangePassLoadingSuccessfulState(
                isLoading: false,
                isConfirmErr: true,
                confirmErrMsg: 'Mật khẩu không đủ mạnh',
              ),
            );
          }
          if (e.code == 'requires-recent-login') {
            emit(
              const ChangePassLoadingSuccessfulState(
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
