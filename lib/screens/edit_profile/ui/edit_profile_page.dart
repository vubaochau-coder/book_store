import 'dart:io';
import 'package:book_store/screens/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:book_store/screens/edit_profile/ui/edit_profile_loading.dart';
import 'package:book_store/screens/profile/bloc/user_bloc.dart';
import 'package:book_store/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? avatar;

  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _dateController;
  List<String> sex = ['Nam', 'Nữ'];

  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  String gender = '';

  bool isNameErr = false;
  bool isPhoneErr = false;
  bool birthdayErr = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _dateController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileBloc, EditProfileState>(
      bloc: BlocProvider.of<EditProfileBloc>(context)
        ..add(EditProfileLoadingEvent()),
      listener: (context, state) {
        if (state is EditProfileNavigateState) {
          BlocProvider.of<UserBloc>(context).add(UserLoadingEvent());
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state is EditProfileLoadingState) {
          return Scaffold(
              extendBodyBehindAppBar: true,
              resizeToAvoidBottomInset: false,
              backgroundColor: background,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: const EditProfileLoading());
        } else if (state is EditProfileLoadingSuccessfulState) {
          return Stack(
            children: [
              Scaffold(
                extendBodyBehindAppBar: true,
                resizeToAvoidBottomInset: false,
                backgroundColor: background,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        const SizedBox(
                          height: 250,
                        ),
                        Image.asset(
                          'images/background.jpg',
                          height: 190,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 2,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: avatar == null
                                    ? CachedNetworkImage(
                                        imageUrl: state.avtURL,
                                        imageBuilder: (context, imageProvider) {
                                          return Container(
                                            width: 120,
                                            height: 120,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : Container(
                                        width: 120,
                                        height: 120,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(1000),
                                          child: Image.file(
                                            avatar!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                              ),
                              Positioned(
                                left: 104,
                                right: 0,
                                bottom: 18,
                                child: GestureDetector(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[100],
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt_outlined,
                                      size: 24,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 6, right: 6, top: 28),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Tên của bạn',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TextField(
                                controller: _nameController,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                                onChanged: (value) {
                                  resetErr();
                                },
                                decoration: InputDecoration(
                                  errorText:
                                      isNameErr ? 'Tối thiểu 6 ký tự' : null,
                                  hintText: state.name,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 0),
                                  focusedErrorBorder: textFieldBorder3,
                                  enabledBorder: textFieldBorder3,
                                  focusedBorder: textFieldBorder3,
                                  errorBorder: textFieldBorder3,
                                ),
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              const Text(
                                'Số điện thoại',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TextField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                  errorText: isPhoneErr
                                      ? 'Số điện thoại không hợp lệ'
                                      : null,
                                  hintText: state.phone == ''
                                      ? 'Chưa cập nhật'
                                      : state.phone,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 0),
                                  focusedErrorBorder: textFieldBorder3,
                                  enabledBorder: textFieldBorder3,
                                  focusedBorder: textFieldBorder3,
                                  errorBorder: textFieldBorder3,
                                ),
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Giới tính',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        DropdownButtonFormField2(
                                          value: state.isMale
                                              ? sex.first
                                              : sex.last,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding: EdgeInsets.zero,
                                            enabledBorder: textFieldBorder3,
                                            focusedBorder: textFieldBorder3,
                                          ),
                                          dropdownStyleData: DropdownStyleData(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            elevation: 4,
                                          ),
                                          isExpanded: true,
                                          buttonStyleData:
                                              const ButtonStyleData(
                                            height: 48,
                                            padding: EdgeInsets.only(right: 8),
                                          ),
                                          items: sex
                                              .map((e) => DropdownMenuItem(
                                                    value: e,
                                                    child: Text(
                                                      e,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                          onChanged: (value) {
                                            if (value == 'Nam') {
                                              gender = 'nam';
                                            } else {
                                              gender = 'nu';
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Ngày sinh',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        TextField(
                                          controller: _dateController,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            errorText: birthdayErr
                                                ? 'Ngày sinh không được trống'
                                                : null,
                                            hintText: state.birthday == ''
                                                ? 'Chưa cập nhật'
                                                : state.birthday,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 12),
                                            focusedErrorBorder:
                                                textFieldBorder3,
                                            enabledBorder: textFieldBorder3,
                                            focusedBorder: textFieldBorder3,
                                            errorBorder: textFieldBorder3,
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                showDatePicker(
                                                  builder: (context, child) {
                                                    return Theme(
                                                      data: Theme.of(context)
                                                          .copyWith(
                                                              colorScheme:
                                                                  ColorScheme
                                                                      .light(
                                                        primary: themeColor,
                                                        onPrimary: Colors.white,
                                                      )),
                                                      child: child!,
                                                    );
                                                  },
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1900),
                                                  lastDate: DateTime.now(),
                                                ).then((value) {
                                                  if (value != null) {
                                                    _dateController.text =
                                                        dateFormat
                                                            .format(value);
                                                  }
                                                });
                                              },
                                              icon: Icon(
                                                Icons.calendar_month,
                                                color: themeColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 48,
                      margin:
                          const EdgeInsets.only(bottom: 14, left: 6, right: 6),
                      child: ElevatedButton(
                        onPressed: () {
                          if (validateData(state.phone, state.birthday)) {
                            String newName = getName(state.name);
                            String newPhone = getPhone(state.phone);
                            String newBirthday = getBirthday(state.birthday);
                            bool newGender = getGender(state.isMale);

                            BlocProvider.of<EditProfileBloc>(context).add(
                              EditProfileChangingEvent(
                                image: avatar,
                                name: newName,
                                phone: newPhone,
                                gender: newGender,
                                birthday: newBirthday,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Cập nhật',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              state.isLoading ? progressDialogue(context) : const SizedBox(),
            ],
          );
        } else {
          return Scaffold(
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: false,
            backgroundColor: background,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: const Center(
              child: Text('Something went wrong'),
            ),
          );
        }
      },
    );
  }

  void resetErr() {
    setState(() {
      isNameErr = isPhoneErr = birthdayErr = false;
    });
  }

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemporary = File(image.path);

    setState(() {
      avatar = imageTemporary;
    });
  }

  bool validateData(String oldPhone, String oldBirthday) {
    if (_nameController.text.trim().isNotEmpty &&
        _nameController.text.trim().length < 6) {
      setState(() {
        isNameErr = true;
      });
      return false;
    }
    if (_phoneController.text.trim().isEmpty && oldPhone.isEmpty) {
      setState(() {
        isPhoneErr = true;
      });
      return false;
    }
    if (_phoneController.text.trim().isNotEmpty &&
        _phoneController.text.trim().length != 10) {
      setState(() {
        isPhoneErr = true;
      });
      return false;
    }
    if (_dateController.text.trim().isEmpty && oldBirthday.isEmpty) {
      setState(() {
        birthdayErr = true;
      });
      return false;
    }
    return true;
  }

  String getName(String oldName) {
    if (_nameController.text.trim().isEmpty) {
      return oldName;
    }
    return _nameController.text.trim();
  }

  String getPhone(String oldPhone) {
    if (_phoneController.text.trim().isEmpty) {
      return oldPhone;
    }
    return _phoneController.text.trim();
  }

  String getBirthday(String oldBirthday) {
    if (_dateController.text.trim().isEmpty) {
      return oldBirthday;
    }
    return _dateController.text.trim();
  }

  bool getGender(bool isMale) {
    if (gender != '') {
      if (gender == 'nam') {
        return true;
      }
      return false;
    }
    return isMale;
  }

  Widget progressDialogue(BuildContext context) {
    return Container(
      color: Colors.black54,
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingAnimationWidget.fourRotatingDots(
            color: Colors.white,
            size: 80,
          ),
          const SizedBox(
            height: 12,
          ),
          const Material(
            color: Colors.transparent,
            child: Text(
              'Đang cập nhật thông tin',
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
