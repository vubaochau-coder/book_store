import 'package:book_store/models/payment_method_model.dart';
import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentMethodListPage extends StatefulWidget {
  final List<PaymentMethodModel> payments;
  final void Function(List<PaymentMethodModel> list) onFinished;
  const PaymentMethodListPage(
      {super.key, required this.payments, required this.onFinished});

  @override
  State<PaymentMethodListPage> createState() => _PaymentMethodListPageState();
}

class _PaymentMethodListPageState extends State<PaymentMethodListPage> {
  List<PaymentMethodModel> tempList = [];

  @override
  void initState() {
    super.initState();
    tempList.clear();
    tempList = List.from(widget.payments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Phương thức thanh toán'),
        centerTitle: true,
        backgroundColor: themeColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: 4,
            width: 10,
            color: Colors.transparent,
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (index != 0) {
                      Fluttertoast.showToast(msg: 'Chức năng đang phát triển');
                    }
                    // setState(() {
                    //   tempList = updateList(index);
                    // });
                  },
                  child: Container(
                    height: 64,
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 64,
                          width: 4,
                          color: tempList[index].isSelected
                              ? themeColor
                              : Colors.grey,
                          margin: const EdgeInsets.only(right: 12),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 8),
                          child: tempList[index].image == ''
                              ? FaIcon(
                                  FontAwesomeIcons.peopleCarryBox,
                                  color: tempList[index].isSelected
                                      ? themeColor
                                      : Colors.grey,
                                  size: 20,
                                )
                              : Icon(
                                  Icons.phone_android,
                                  color: tempList[index].isSelected
                                      ? themeColor
                                      : Colors.grey,
                                  size: 24,
                                ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              children: [
                                Text(
                                  tempList[index].name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                tempList[index].image != ''
                                    ? Image.asset(
                                        tempList[index].image,
                                        height: 20,
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.check,
                            color: tempList[index].isSelected
                                ? themeColor
                                : Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 0,
                  thickness: 2,
                );
              },
              itemCount: tempList.length,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: Colors.white,
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  widget.onFinished(tempList);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Xác nhận',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PaymentMethodModel> updateList(int index) {
    List<PaymentMethodModel> result = [];
    for (int i = 0; i < widget.payments.length; i++) {
      if (i != index) {
        PaymentMethodModel temp = PaymentMethodModel(
          id: widget.payments[i].id,
          name: widget.payments[i].name,
          image: widget.payments[i].image,
          isSelected: false,
        );
        result.add(temp);
      } else {
        PaymentMethodModel temp = PaymentMethodModel(
          id: widget.payments[i].id,
          name: widget.payments[i].name,
          image: widget.payments[i].image,
          isSelected: true,
        );
        result.add(temp);
      }
    }
    return result;
  }
}
