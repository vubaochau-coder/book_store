import 'package:book_store/CustomWidget/custom_list_tile.dart';
import 'package:book_store/Authentication%20Service/auth_service.dart';
import 'package:book_store/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TaiKhoanPage extends StatelessWidget {
  const TaiKhoanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            themeColor.withAlpha(180),
            themeColor.withAlpha(240),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.gear,
                    color: Colors.white,
                    size: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: getPhotoUrl() != ""
                              ? Image.network(
                                  getPhotoUrl(),
                                  fit: BoxFit.contain,
                                  width: 58,
                                  height: 58,
                                )
                              : Image.asset(
                                  'images/user.png',
                                  fit: BoxFit.contain,
                                  width: 62,
                                  height: 62,
                                ),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      SizedBox(
                        height: 62,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getNameUser(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                color: Colors.white,
                              ),
                              child: Text(
                                'Thành viên Bạc',
                                style: TextStyle(
                                  color: themeColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const SizedBox(
                    height: 18,
                  ),
                  const LinearProgressIndicator(
                    value: 0.3,
                    backgroundColor: Colors.white,
                    color: Colors.amber,
                  ),
                  Positioned(
                    left: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Bạc',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Vàng',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              margin: const EdgeInsets.only(
                top: 18,
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
                        child: SizedBox(
                          height: 82,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.envelopeOpenText,
                                color: themeColor,
                                size: 28,
                              ),
                              const Text(
                                'Chờ xác thực',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 82,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.box,
                                color: themeColor,
                                size: 28,
                              ),
                              const Text(
                                'Chờ lấy hàng',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 82,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.truckFast,
                                color: themeColor,
                                size: 28,
                              ),
                              const Text(
                                'Đang giao',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Builder(builder: (context) {
                        return Expanded(
                          child: SizedBox(
                            height: 82,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.star,
                                  color: themeColor,
                                  size: 28,
                                ),
                                const Text(
                                  'Chưa đánh giá',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            CustomListTile(
              title: 'Đã thích',
              leading: FontAwesomeIcons.heart,
              onPressed: () {},
            ),
            CustomListTile(
              title: 'Thay đổi thông tin',
              leading: Icons.person,
              onPressed: () {},
            ),
            CustomListTile(
              title: 'Địa chỉ giao hàng',
              leading: Icons.edit_location_alt,
              onPressed: () {},
            ),
            const SizedBox(
              height: 18,
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

  String getNameUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.displayName!;
    }
    return "Username";
  }

  String getPhotoUrl() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.photoURL!;
    }
    return "";
  }
}
