import 'package:badges/badges.dart' as badge;
import 'package:book_store/app_themes/app_fonts.dart';
import 'package:book_store/authentication_service/auth_service.dart';
import 'package:book_store/screens/checkout/bloc/checkout_bloc.dart';
import 'package:book_store/screens/cart/bloc/cart_bloc.dart';
import 'package:book_store/screens/cart/ui/cart_page.dart';
import 'package:book_store/screens/edit_password/bloc/edit_pass_bloc.dart';
import 'package:book_store/screens/home/bloc/home_bloc.dart';
import 'package:book_store/screens/home/ui/home_page.dart';
import 'package:book_store/screens/notification/bloc/notification_bloc.dart';
import 'package:book_store/screens/notification/ui/notification_page.dart';
import 'package:book_store/screens/order_bill/bloc/bill_bloc.dart';
import 'package:book_store/screens/product_detail/bloc/product_bloc.dart';
import 'package:book_store/screens/profile/bloc/feedback_count_bloc.dart';
import 'package:book_store/screens/profile/bloc/user_bloc.dart';
import 'package:book_store/screens/profile/ui/profile_page.dart';
import 'package:book_store/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'screens/search/bloc/search_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc()..add(HomeLoadingEvent())),
        BlocProvider(create: (context) => ProductBloc()),
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => CheckoutBloc()),
        BlocProvider(create: (context) => BillBloc()),
        BlocProvider(create: (context) => SearchBloc()),
        BlocProvider(create: (context) => FeedbackCountBloc()),
        BlocProvider(create: (context) => EditPasswordBloc()),
        BlocProvider(create: (context) => NotificationBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Book Store',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Averta',
        ),
        home: AuthService().handleAuthState(),
      ),
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
    HomePage(),
    NotificationPage(),
    CartPage(),
    ProfilePage(),
  ];

  final controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: pages,
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
      ),
      bottomNavigationBar: SalomonBottomBar(
        selectedItemColor: themeColor,
        currentIndex: currentPage,
        unselectedItemColor: Colors.grey,
        onTap: (p0) {
          controller.animateToPage(
            p0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInQuint,
          );
        },
        items: [
          SalomonBottomBarItem(
            icon: const FaIcon(
              FontAwesomeIcons.houseCrack,
              size: 18,
            ),
            title: Text(
              'Trang chủ',
              style: TextStyle(fontFamily: AppFonts.averta),
            ),
          ),
          SalomonBottomBarItem(
            icon: BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const FaIcon(
                    FontAwesomeIcons.solidMessage,
                    size: 18,
                  );
                }
                int count = state.allNotis
                    .where((element) => element.isRead == false)
                    .length;

                return badge.Badge(
                  showBadge: count > 0,
                  badgeContent: Text(
                    count.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  badgeStyle: const badge.BadgeStyle(
                    padding: EdgeInsets.all(4),
                  ),
                  child: const FaIcon(
                    FontAwesomeIcons.solidMessage,
                    size: 18,
                  ),
                );
              },
            ),
            title: Text(
              'Thông báo',
              style: TextStyle(fontFamily: AppFonts.averta),
            ),
          ),
          SalomonBottomBarItem(
            icon: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const FaIcon(
                    FontAwesomeIcons.cartShopping,
                    size: 18,
                  );
                }
                return badge.Badge(
                  showBadge: state.cartItems.isNotEmpty,
                  badgeContent: Text(
                    state.cartItems.length.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  badgeStyle: const badge.BadgeStyle(
                    padding: EdgeInsets.all(4),
                  ),
                  child: const FaIcon(
                    FontAwesomeIcons.cartShopping,
                    size: 18,
                  ),
                );
              },
            ),
            title: Text(
              'Giỏ hàng',
              style: TextStyle(fontFamily: AppFonts.averta),
            ),
          ),
          SalomonBottomBarItem(
            icon: const FaIcon(
              FontAwesomeIcons.solidUser,
              size: 18,
            ),
            title: Text(
              'Tài khoản',
              style: TextStyle(fontFamily: AppFonts.averta),
            ),
          ),
        ],
      ),
    );
  }
}
