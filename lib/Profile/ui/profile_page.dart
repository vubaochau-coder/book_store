import 'package:book_store/AddressSetting/ui/address_setting.dart';
import 'package:book_store/CustomWidget/custom_list_tile.dart';
import 'package:book_store/Authentication%20Service/auth_service.dart';
import 'package:book_store/CustomWidget/custom_page_route.dart';
import 'package:book_store/CustomWidget/order_status_button.dart';
import 'package:book_store/Profile/bloc/user_bloc.dart';
import 'package:book_store/Profile/ui/change_info_page.dart';
import 'package:book_store/Profile/ui/proflie_loading_page.dart';
import 'package:book_store/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoadingSuccessfulState) {
          return userSuccessState(context, state);
        } else if (state is UserLoadingState) {
          return const ProfileLoadingPage();
        } else {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
      },
    );
  }

  Widget userSuccessState(
      BuildContext context, UserLoadingSuccessfulState state) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 26,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: themeColor,
                          width: 2,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl: state.userModel.imgUrl,
                          fit: BoxFit.contain,
                          width: 66,
                          height: 66,
                          errorWidget: (context, url, error) {
                            return Image.asset(
                              'images/user.png',
                              fit: BoxFit.contain,
                              width: 66,
                              height: 66,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 62,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 14,
                            ),
                            Text(
                              state.userModel.name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Text(
                                  'Chỉnh sửa tài khoản',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return const ChangeInfoPage();
                                    }));
                                  },
                                  child: FaIcon(
                                    size: 14,
                                    FontAwesomeIcons.penToSquare,
                                    color: themeColor,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 4,
              margin: const EdgeInsets.only(
                top: 28,
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Đơn hàng của tôi',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            child: const OrderStatusButton(
                              text: 'Chờ xác thực',
                              icon: FontAwesomeIcons.envelopeOpenText,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            child: const OrderStatusButton(
                              text: 'Chờ lấy hàng',
                              icon: FontAwesomeIcons.box,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            child: const OrderStatusButton(
                              text: 'Đang giao',
                              icon: FontAwesomeIcons.truckFast,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            child: const OrderStatusButton(
                              text: 'Chưa đánh giá',
                              icon: FontAwesomeIcons.star,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            const Text(
              'Tài khoản của tôi',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            CustomListTile(
              title: 'Đã thích',
              leading: FontAwesomeIcons.heart,
              onPressed: () {},
            ),
            CustomListTile(
              title: 'Địa chỉ giao hàng',
              leading: Icons.edit_location_alt,
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteSlideTransition(
                    child: const AddressSettingPage(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 18,
            ),
            const Text(
              'Tổng quát',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            CustomListTile(
              title: 'Thay đổi mật khẩu',
              leading: Icons.vpn_key,
              onPressed: () {},
            ),
            CustomListTile(
              title: 'Trợ giúp',
              leading: Icons.help_outline,
              onPressed: () {},
            ),
            CustomListTile(
              title: 'Đăng xuất',
              leading: Icons.logout,
              onPressed: () {
                AuthService().signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
