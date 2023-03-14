import 'package:badges/badges.dart';
import 'package:book_store/ChoBan/cho_ban_page.dart';
import 'package:book_store/GioHang/gio_hang_page.dart';
import 'package:book_store/TaiKhoan/tai_khoan_page.dart';
import 'package:book_store/TinNhan/tin_nhan_page.dart';
import 'package:book_store/TrangChu/trang_chu_page.dart';
import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Book Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;

  List<Widget> pages = const [
    TrangChuPage(),
    TinNhanPage(),
    ChoBanPage(),
    GioHangPage(),
    TaiKhoanPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: SalomonBottomBar(
        selectedItemColor: themeColor,
        currentIndex: currentPage,
        unselectedItemColor: Colors.grey,
        onTap: (p0) {
          setState(() {
            currentPage = p0;
          });
        },
        items: [
          SalomonBottomBarItem(
            icon: const FaIcon(
              FontAwesomeIcons.houseCrack,
              size: 18,
            ),
            title: const Text('Trang chủ'),
          ),
          SalomonBottomBarItem(
            icon: const Badge(
              showBadge: true,
              badgeContent: Text(
                '3',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              badgeStyle: BadgeStyle(
                padding: EdgeInsets.all(4),
              ),
              child: FaIcon(
                FontAwesomeIcons.message,
                size: 18,
              ),
            ),
            title: const Text('Tin nhắn'),
          ),
          SalomonBottomBarItem(
            icon: const FaIcon(
              FontAwesomeIcons.heart,
              size: 18,
            ),
            title: const Text('Cho bạn'),
          ),
          SalomonBottomBarItem(
            icon: const Badge(
              badgeContent: Text(
                '4',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              badgeStyle: BadgeStyle(
                padding: EdgeInsets.all(4),
              ),
              child: FaIcon(
                FontAwesomeIcons.cartShopping,
                size: 18,
              ),
            ),
            title: const Text('Giỏ hàng'),
          ),
          SalomonBottomBarItem(
            icon: const FaIcon(
              FontAwesomeIcons.user,
              size: 18,
            ),
            title: const Text('Tài khoản'),
          ),
        ],
      ),
    );
  }
}
