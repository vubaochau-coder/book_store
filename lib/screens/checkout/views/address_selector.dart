import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/screens/checkout/bloc/checkout_bloc.dart';
import 'package:book_store/screens/checkout/ui/address_loading.dart';
import 'package:book_store/utils/address_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../custom_widgets/custom_page_route.dart';
import '../../address_setting/ui/address_setting.dart';

class AddressSelector extends StatelessWidget {
  const AddressSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      buildWhen: (previous, current) {
        return previous.isLoading != current.isLoading ||
            previous.userAddress != current.userAddress;
      },
      builder: (context, state) {
        if (state.isLoading || state is CheckoutOrderSuccessfulState) {
          return const LoadingAddress();
        }

        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              PageRouteSlideTransition(
                child: const AddressSettingPage(),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            margin: const EdgeInsets.only(top: 4),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.pin_drop_outlined,
                            color: AppColors.themeColor,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Text(
                            'Địa chỉ giao hàng',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.pin_drop_outlined,
                            color: Colors.transparent,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: Text(
                              AddressUtils.convertAddressModel(
                                  state.userAddress),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.themeColor,
                  size: 16,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
