import 'package:book_store/screens/checkout/bloc/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app_themes/app_colors.dart';
import '../../../custom_widgets/custom_page_route.dart';
import '../../../utils/convert.dart';
import '../ui/transport_page.dart';

class TransportSelector extends StatelessWidget {
  const TransportSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      buildWhen: (previous, current) {
        return previous.isLoading != current.isLoading ||
            previous.selectedTransport != current.selectedTransport;
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: state.isLoading
              ? null
              : () {
                  Navigator.of(context).push(
                    PageRouteSlideTransition(
                      child: TransportListPage(
                        onFinished: (p0) {
                          BlocProvider.of<CheckoutBloc>(context).add(
                            CheckoutUpdateTransportEvent(newTransport: p0),
                          );
                          Navigator.of(context).pop();
                        },
                        transports: state.transports,
                        selectedTransport: state.selectedTransport,
                      ),
                    ),
                  );
                },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            margin: const EdgeInsets.only(top: 4),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 246, 255, 254),
              border: Border(
                top: BorderSide(
                  color: Color.fromARGB(255, 198, 221, 218),
                ),
                bottom: BorderSide(
                  color: Color.fromARGB(255, 198, 221, 218),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.delivery_dining_outlined,
                      size: 18,
                      color: AppColors.themeColor,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text(
                      'Phương thức vận chuyển',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                  height: 24,
                ),
                state.isLoading
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Shimmer.fromColors(
                            baseColor: AppColors.baseShimmer,
                            highlightColor: AppColors.highlightShimmer,
                            child: Container(
                              width: 88,
                              height: 20,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Shimmer.fromColors(
                            baseColor: AppColors.baseShimmer,
                            highlightColor: AppColors.highlightShimmer,
                            child: Container(
                              width: 88,
                              height: 20,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              state.selectedTransport!.name,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const Text(
                            'đ',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Text(
                            Converter.convertNumberToMoney(
                                state.selectedTransport!.price),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: AppColors.themeColor,
                            size: 16,
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 4,
                ),
                state.isLoading
                    ? Shimmer.fromColors(
                        baseColor: AppColors.baseShimmer,
                        highlightColor: AppColors.highlightShimmer,
                        child: Container(
                          width: 176,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Text(
                        'Nhận hàng sau ${state.selectedTransport!.min}-${state.selectedTransport!.max} ngày',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
