import 'package:book_store/theme.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ChangeInfoPage extends StatelessWidget {
  const ChangeInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: 'Vũ Bảo Châu');
    TextEditingController phoneController = TextEditingController();
    TextEditingController dateController =
        TextEditingController(text: 'Chưa cập nhật');
    List<String> sex = ['Nam', 'Nữ'];
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
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
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          'images/user.png',
                          fit: BoxFit.contain,
                          width: 120,
                          height: 120,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 104,
                      right: 0,
                      bottom: 18,
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
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14, right: 14, top: 28),
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
                  controller: nameController,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    fillColor: Colors.white,
                    filled: true,
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
                InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber phoneNumber) {},
                  formatInput: true,
                  textFieldController: phoneController,
                  initialValue: PhoneNumber(isoCode: 'VN'),
                  inputDecoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    focusedErrorBorder: textFieldBorder3,
                    enabledBorder: textFieldBorder3,
                    focusedBorder: textFieldBorder3,
                    errorBorder: textFieldBorder3,
                  ),
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            value: sex.first,
                            validator: (value) {
                              if (value == null) {
                                return 'Chọn';
                              }
                              return value;
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: textFieldBorder3,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                            ),
                            isExpanded: true,
                            buttonStyleData: const ButtonStyleData(
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
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {},
                            onSaved: (newValue) {},
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            controller: dateController,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              border: textFieldBorder3,
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
          Container(
            width: 242,
            height: 48,
            margin: const EdgeInsets.only(top: 48),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: themeColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
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
    );
  }
}
