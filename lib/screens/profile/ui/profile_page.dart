import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/authentication_service/auth_service.dart';
import 'package:book_store/screens/profile/ui/custom_list_tile.dart';
import 'package:book_store/custom_widgets/custom_page_route.dart';
import 'package:book_store/screens/profile/ui/transaction_status_banner.dart';
import 'package:book_store/screens/address_setting/ui/address_setting.dart';
import 'package:book_store/screens/edit_password/ui/edit_pass_page.dart';
import 'package:book_store/screens/edit_profile/ui/edit_profile_page.dart';
import 'package:book_store/screens/my_favorite/ui/favorite_page.dart';
import 'package:book_store/screens/profile/bloc/user_bloc.dart';
import 'package:book_store/screens/profile/ui/proflie_loading_page.dart';
import 'package:book_store/screens/profile/ui/support_page.dart';
import 'package:book_store/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../transaction_status/ui/transaction_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: AppColors.background,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 26,
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const ProfileLoadingPage();
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: SafeArea(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(
                              PageRouteSlideTransition(
                                child: const EditProfilePage(),
                              ),
                            )
                                .then((value) {
                              if (value != null && value == true) {
                                BlocProvider.of<UserBloc>(context).add(
                                  UserLoadingEvent(),
                                );
                              }
                            });
                          },
                          child: Container(
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
                                imageUrl: state.userModel!.imgUrl,
                                fit: BoxFit.cover,
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
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 62,
                            child: Row(
                              children: [
                                const SizedBox(width: 6),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 14,
                                    ),
                                    Text(
                                      state.userModel!.name,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    const Text(
                                      'Chỉnh sửa tài khoản',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(
                                      PageRouteSlideTransition(
                                        child: const EditProfilePage(),
                                      ),
                                    )
                                        .then((value) {
                                      if (value != null && value == true) {
                                        BlocProvider.of<UserBloc>(context).add(
                                          UserLoadingEvent(),
                                        );
                                      }
                                    });
                                  },
                                  padding: EdgeInsets.zero,
                                  icon: FaIcon(
                                    size: 14,
                                    FontAwesomeIcons.penToSquare,
                                    color: themeColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const TransactionStatusBanner(),
            const Padding(
              padding: EdgeInsets.only(left: 2),
              child: Text(
                'Tài khoản của tôi',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            CustomListTile(
              title: 'Đã thích',
              leading: FontAwesomeIcons.heart,
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteSlideTransition(
                    child: const FavoritePage(),
                  ),
                );
              },
            ),
            CustomListTile(
              title: 'Lịch sử mua hàng',
              leading: FontAwesomeIcons.peopleCarryBox,
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteSlideTransition(
                    child: const TransactionPage(
                      currentIndex: 3,
                    ),
                  ),
                );
              },
            ),
            CustomListTile(
              title: 'Địa chỉ giao hàng',
              leading: Icons.edit_location_alt_outlined,
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteSlideTransition(
                    child: const AddressSettingPage(),
                  ),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.only(left: 2, top: 18, bottom: 8),
              child: Text(
                'Tổng quát',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ),
            ),
            CustomListTile(
              title: 'Thay đổi mật khẩu',
              leading: Icons.vpn_key_outlined,
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteSlideTransition(
                    child: const EditPasswordPage(),
                  ),
                );
              },
            ),
            CustomListTile(
              title: 'Trợ giúp',
              leading: Icons.help_outline,
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteSlideTransition(
                    child: const SupportPage(),
                  ),
                );
              },
            ),
            CustomListTile(
              title: 'Đăng xuất',
              leading: Icons.logout,
              onPressed: () {
                AuthService().signOut();
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
