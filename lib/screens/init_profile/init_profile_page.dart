import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/app_themes/app_text.dart';
import 'package:book_store/authentication_service/auth_service.dart';
import 'package:book_store/utils/convert.dart';
import 'views/birthday_selector.dart';
import 'views/gender_radio.dart';
import 'views/label.dart';
import 'views/profile_textfield.dart';
import 'bloc/init_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitProfilePage extends StatefulWidget {
  const InitProfilePage({super.key});

  @override
  State<InitProfilePage> createState() => _InitProfilePageState();
}

class _InitProfilePageState extends State<InitProfilePage> {
  late FocusNode _nameFocus, _phoneFocus;

  @override
  void initState() {
    _nameFocus = FocusNode();
    _phoneFocus = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.themeColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColors.themeColor,
          foregroundColor: AppColors.contentColor,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () async {
                await AuthService().signOut();
              },
              icon: const Icon(Icons.logout),
            )
          ],
          title: Text(
            'Khởi tạo tài khoản',
            style: AppTexts.appbarTitle.copyWith(fontSize: 22),
          ),
        ),
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.only(top: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(36),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 22),
                Text(
                  'Hoàn tất việc thiết lập thông tin tài khoản trước khi sử dụng ứng dụng',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.themeColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                const Label(label: 'Họ và tên'),
                BlocBuilder<InitProfileBloc, InitProfileState>(
                  buildWhen: (previous, current) {
                    return previous.errName != current.errName;
                  },
                  builder: (context, state) {
                    return ProfileTextField(
                      hintText: 'Họ và tên',
                      errorText: state.errName,
                      focusNode: _nameFocus,
                      onChanged: (p0) {
                        context
                            .read<InitProfileBloc>()
                            .add(UpdateNameEvent(name: p0));
                      },
                      onEditingComplete: () {
                        _phoneFocus.requestFocus();
                      },
                      textCapitalization: TextCapitalization.words,
                    );
                  },
                ),
                const Label(label: 'Số điện thoại'),
                BlocBuilder<InitProfileBloc, InitProfileState>(
                  buildWhen: (previous, current) {
                    return previous.errPhone != current.errPhone;
                  },
                  builder: (context, state) {
                    return ProfileTextField(
                      hintText: 'Số điện thoại',
                      keyboardType: TextInputType.phone,
                      errorText: state.errPhone,
                      focusNode: _phoneFocus,
                      onChanged: (p0) {
                        context
                            .read<InitProfileBloc>()
                            .add(UpdatePhoneEvent(phone: p0));
                      },
                      onEditingComplete: () {},
                    );
                  },
                ),
                const Label(label: 'Ngày sinh'),
                BlocBuilder<InitProfileBloc, InitProfileState>(
                  buildWhen: (previous, current) {
                    return previous.birthday != current.birthday ||
                        previous.errBirthday != current.errBirthday;
                  },
                  builder: (context, state) {
                    return BirthdaySelector(
                      intiText: state.birthday != null
                          ? Converter.convertDateToStringWithoutTime(
                              state.birthday!)
                          : "",
                    );
                  },
                ),
                const Label(label: 'Giới tính'),
                const GenderRadioButton(),
                const Spacer(),
                SizedBox(
                  height: 48,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<InitProfileBloc>().add(SubmitEvent());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.themeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Hoàn thành',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 10 + MediaQuery.of(context).padding.bottom),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
