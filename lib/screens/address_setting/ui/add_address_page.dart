import 'package:book_store/models/address_model.dart';
import 'package:book_store/screens/address_setting/bloc/address_bloc.dart';
import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Địa chỉ mới'),
        backgroundColor: themeColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildText('Liên hệ'),
            TextField(
              controller: nameController,
              keyboardType: TextInputType.name,
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
                        BlocProvider.of<AddressBloc>(context).add(
                          AddNewAddressEvent(
                            newAddress: AddressModel(
                              id: '',
                              name: nameController.text.trim(),
                              phone: phoneController.text.trim(),
                              address:
                                  '${addressController.text.trim()} ${cityController.text.trim()}',
                              isDefault: false,
                            ),
                          ),
                        );
                        Navigator.of(context).pop();
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: const Text(
                  'Hoàn tất',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12, left: 14),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
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
