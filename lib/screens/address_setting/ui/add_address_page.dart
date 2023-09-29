import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/app_themes/app_text.dart';
import 'package:flutter/material.dart';

class NewAddressPage extends StatefulWidget {
  const NewAddressPage({super.key});

  @override
  State<NewAddressPage> createState() => _NewAddressPageState();
}

class _NewAddressPageState extends State<NewAddressPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool isValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Địa chỉ mới',
          style: AppTexts.appbarTitle,
        ),
        backgroundColor: AppColors.themeColor,
        foregroundColor: AppColors.contentColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildText('Liên hệ',
                const EdgeInsets.only(top: 14, bottom: 12, left: 14)),
            TextField(
              controller: nameController,
              keyboardType: TextInputType.name,
              style: AppTexts.inputTextStyle,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 14),
                fillColor: Colors.white,
                filled: true,
                hintText: 'Họ và Tên',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  isValidate = isDataNotEmpty();
                });
              },
            ),
            const SizedBox(
              height: 4,
            ),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              style: AppTexts.inputTextStyle,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 14),
                fillColor: Colors.white,
                filled: true,
                hintText: 'Số điện thoại',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  isValidate = isDataNotEmpty();
                });
              },
            ),
            buildText('Địa chỉ'),
            TextField(
              controller: cityController,
              keyboardType: TextInputType.streetAddress,
              style: AppTexts.inputTextStyle,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 14),
                fillColor: Colors.white,
                filled: true,
                hintText: 'Tỉnh/Thành phố, Quận/Huyện, Phường/Xã',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  isValidate = isDataNotEmpty();
                });
              },
            ),
            const SizedBox(
              height: 4,
            ),
            TextField(
              controller: addressController,
              keyboardType: TextInputType.streetAddress,
              style: AppTexts.inputTextStyle,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 14),
                fillColor: Colors.white,
                filled: true,
                hintText: 'Tên đường, tòa nhà, số nhà',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  isValidate = isDataNotEmpty();
                });
              },
            ),
            Container(
              width: double.infinity,
              height: 48,
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 28),
              child: ElevatedButton(
                onPressed: isValidate
                    ? () {
                        Navigator.of(context).pop({
                          'name': nameController.text.trim(),
                          'phone': phoneController.text.trim(),
                          'address':
                              '${addressController.text.trim()} ${cityController.text.trim()}',
                        });
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.themeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text(
                  'Hoàn tất',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildText(String text,
      [EdgeInsets padding =
          const EdgeInsets.only(top: 24, bottom: 12, left: 14)]) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
    );
  }

  bool isDataNotEmpty() {
    return nameController.text.trim().isNotEmpty &&
        phoneController.text.trim().isNotEmpty &&
        cityController.text.trim().isNotEmpty &&
        addressController.text.trim().isNotEmpty;
  }
}
