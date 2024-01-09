import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/app_themes/app_text.dart';
import 'package:book_store/core/repositories/main_repository.dart';
import 'package:book_store/custom_widgets/custom_page_route.dart';
import 'package:book_store/core/models/address_model.dart';
import 'package:book_store/screens/address_setting/bloc/address_bloc.dart';
import 'package:book_store/screens/address_setting/ui/add_address_page.dart';
import 'package:book_store/screens/address_setting/ui/address_loading.dart';
import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddressSettingPage extends StatelessWidget {
  const AddressSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressBloc(
        RepositoryProvider.of<MainRepository>(context).addressRepository,
      )..add(AddressLoadingEvent()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            'Chọn địa chỉ nhận hàng',
            style: AppTexts.appbarTitle,
          ),
          backgroundColor: AppColors.themeColor,
          foregroundColor: AppColors.contentColor,
          elevation: 0,
          centerTitle: true,
        ),
        body: BlocBuilder<AddressBloc, AddressState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const AddressLoadingPage();
            }

            if (state.listAddress.isEmpty) {
              return addNewAddressButton(context);
            }

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
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const VerticalDivider(
                                        color: Colors.black,
                                        width: 16,
                                        indent: 2,
                                        endIndent: 2,
                                      ),
                                      Expanded(
                                        child: Text(
                                          state.listAddress[index].phone,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  state.listAddress[index].address,
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
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
                          child: Text(
                            'Xóa',
                            style: TextStyle(
                              color: themeColor,
                              fontWeight: FontWeight.bold,
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
          },
        ),
      ),
    );
  }

  Widget addNewAddressButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            PageRouteSlideTransition(
              child: const NewAddressPage(),
            ),
          )
              .then((value) {
            if (value != null) {
              Map<String, dynamic> map = (value as Map<String, dynamic>);
              BlocProvider.of<AddressBloc>(context).add(
                AddNewAddressEvent(
                  newAddress: AddressModel(
                    id: '',
                    name: map['name'],
                    phone: map['phone'],
                    address: map['address'],
                    isDefault: false,
                  ),
                ),
              );
            }
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: themeColor,
              width: 1,
            ),
          ),
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
