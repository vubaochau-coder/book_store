import 'package:book_store/models/transport_model.dart';
import 'package:book_store/theme.dart';
import 'package:book_store/utils/convert.dart';
import 'package:flutter/material.dart';

class TransportListPage extends StatefulWidget {
  final List<TransportModel> transports;
  final void Function(List<TransportModel> list) onFinished;
  const TransportListPage(
      {super.key, required this.transports, required this.onFinished});

  @override
  State<TransportListPage> createState() => _TransportListPageState();
}

class _TransportListPageState extends State<TransportListPage> {
  List<TransportModel> tempList = [];
  @override
  void initState() {
    super.initState();
    tempList.clear();
    tempList = List.from(widget.transports);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Phương thức vận chuyển'),
        centerTitle: true,
        backgroundColor: themeColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            color: Colors.grey[200],
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Các phương thức vận chuyển của IBOO',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Image.asset(
                      'images/logo_fill_crop.png',
                      fit: BoxFit.contain,
                      height: 20,
                    ),
                  ],
                ),
                const Text(
                    'Bạn có thể theo dõi đơn hàng trên ứng dụng IBOO khi chọn một trong các đơn vị vận chuyển:'),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      tempList = updateList(index);
                    });
                  },
                  child: Container(
                    height: 64,
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 64,
                          width: 4,
                          color: tempList[index].isSelected
                              ? themeColor
                              : Colors.grey,
                          margin: const EdgeInsets.only(right: 12),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        tempList[index].name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      'đ',
                                      style: TextStyle(
                                        color: tempList[index].isSelected
                                            ? themeColor
                                            : Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        Converter.convertNumberToMoney(
                                            tempList[index].price),
                                        style: TextStyle(
                                          color: tempList[index].isSelected
                                              ? themeColor
                                              : Colors.grey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Nhận hàng sau ${tempList[index].min}-${tempList[index].max} ngày',
                                  style: TextStyle(
                                    color: tempList[index].isSelected
                                        ? Colors.grey
                                        : Colors.grey[400],
                                    fontWeight: tempList[index].isSelected
                                        ? FontWeight.w400
                                        : FontWeight.w300,
                                  ),
                                ),
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

  List<TransportModel> updateList(int index) {
    List<TransportModel> result = [];
    for (int i = 0; i < widget.transports.length; i++) {
      if (i != index) {
        TransportModel temp = TransportModel(
          id: widget.transports[i].id,
          name: widget.transports[i].name,
          description: widget.transports[i].description,
          price: widget.transports[i].price,
          min: widget.transports[i].min,
          max: widget.transports[i].max,
          isSelected: false,
        );
        result.add(temp);
      } else {
        TransportModel temp = TransportModel(
          id: widget.transports[i].id,
          name: widget.transports[i].name,
          description: widget.transports[i].description,
          price: widget.transports[i].price,
          min: widget.transports[i].min,
          max: widget.transports[i].max,
          isSelected: true,
        );
        result.add(temp);
      }
    }
    return result;
  }
}
