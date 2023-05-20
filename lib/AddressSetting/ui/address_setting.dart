import 'package:book_store/AddressSetting/bloc/address_bloc.dart';
import 'package:book_store/AddressSetting/ui/address_loading.dart';
import 'package:book_store/AddressSetting/ui/add_address_page.dart';
import 'package:book_store/Checkout/bloc/checkout_bloc.dart';
import 'package:book_store/CustomWidget/custom_page_route.dart';
import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddressSettingPage extends StatelessWidget {
  const AddressSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn địa chỉ nhận hàng'),
        backgroundColor: themeColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<AddressBloc, AddressState>(
        bloc: BlocProvider.of<AddressBloc>(context)..add(AddressLoadingEvent()),
        builder: (context, state) {
          if (state is AddressLoadingState) {
            return const AddressLoadingPage();
          } else if (state is AddressLoadingSuccessfulState) {
            return ListView.separated(
              itemBuilder: (context, index) {
                if (index < state.listAddress.length) {
                  return Container(
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: state.listAddress[index].isDefault,
                          activeColor: themeColor,
                          shape: const CircleBorder(),
                          onChanged: (value) {
                            BlocProvider.of<AddressBloc>(context).add(
                              AddressSelectedEvent(
                                  id: state.listAddress[index].id),
                            );
                            BlocProvider.of<CheckoutBloc>(context)
                                .add(CheckoutLoadingEvent());
                            Navigator.of(context).pop();
                          },
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Text(
                                        state.listAddress[index].name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const VerticalDivider(
                                        color: Colors.black,
                                        width: 16,
                                        indent: 2,
                                        endIndent: 2,
                                      ),
                                      Text(state.listAddress[index].phone),
                                    ],
                                  ),
                                ),
                                Text(state.listAddress[index].address),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (state.listAddress[index].isDefault) {
                              Fluttertoast.showToast(
                                msg: 'Không thể xóa địa chỉ giao hàng mặc định',
                                toastLength: Toast.LENGTH_LONG,
                              );
                            } else {
                              BlocProvider.of<AddressBloc>(context).add(
                                RemoveAddressEvent(
                                    idAddress: state.listAddress[index].id),
                              );
                            }
                          },
                          child: SizedBox(
                            height: 40,
                            width: 52,
                            child: Center(
                              child: Text(
                                'Xóa',
                                style: TextStyle(
                                  color: themeColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return addNewAddressButton(context);
                }
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 0,
                  thickness: 2,
                );
              },
              itemCount: state.listAddress.length + 1,
            );
          } else if (state is AddressEmptyState) {
            return addNewAddressButton(context);
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        },
      ),
    );
  }

  Widget addNewAddressButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: themeColor,
          width: 1,
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            PageRouteSlideTransition(
              child: const NewAddressPage(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              color: themeColor,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              'Thêm Địa Chỉ Mới',
              style: TextStyle(
                color: themeColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
