import 'package:badges/badges.dart';
import 'package:book_store/Cart/bloc/cart_bloc.dart';
import 'package:book_store/Cart/ui/cart_page.dart';
import 'package:book_store/Category/ChildCategory/bloc/child_bloc.dart';
import 'package:book_store/Category/ComicCategory/bloc/comic_bloc.dart';
import 'package:book_store/Category/LiteratureCategory/bloc/literature_bloc.dart';
import 'package:book_store/Category/OtherCategory/bloc/other_bloc.dart';
import 'package:book_store/Category/SGKCategory/bloc/sgk_bloc.dart';
import 'package:book_store/Category/ScienceCategory/bloc/science_bloc.dart';
import 'package:book_store/Home/bloc/home_bloc.dart';
import 'package:book_store/ProductDetail/bloc/product_bloc.dart';
import 'package:book_store/Profile/ui/tai_khoan_page.dart';
import 'package:book_store/Notification/tin_nhan_page.dart';
import 'package:book_store/Home/ui/home_page.dart';
import 'package:book_store/Authentication%20Service/auth_service.dart';
import 'package:book_store/bloc/main_bloc.dart';
import 'package:book_store/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

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
        BlocProvider(create: (context) => CartBloc()..add(CartLoadingEvent())),
        BlocProvider(create: (context) => MainBloc()..add(MainLoadingEvent())),
        BlocProvider(create: (context) => SgkBloc()),
        BlocProvider(create: (context) => LiteratureBloc()),
        BlocProvider(create: (context) => ComicBloc()),
        BlocProvider(create: (context) => ChildBloc()),
        BlocProvider(create: (context) => ScienceBloc()),
        BlocProvider(create: (context) => OtherBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Book Store',
        theme: ThemeData(
          primarySwatch: Colors.blue,
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
    TinNhanPage(),
    GioHangPage(),
    TaiKhoanPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        if (state is MainLoadingSuccessfulState) {
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
                  icon: Badge(
                    showBadge: state.messNumber > 0 ? true : false,
                    badgeContent: Text(
                      state.messNumber.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    badgeStyle: const BadgeStyle(
                      padding: EdgeInsets.all(4),
                    ),
                    child: const FaIcon(
                      FontAwesomeIcons.solidMessage,
                      size: 18,
                    ),
                  ),
                  title: const Text('Tin nhắn'),
                ),
                SalomonBottomBarItem(
                  icon: Badge(
                    showBadge: state.cartNumber > 0 ? true : false,
                    badgeContent: Text(
                      state.cartNumber.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    badgeStyle: const BadgeStyle(
                      padding: EdgeInsets.all(4),
                    ),
                    child: const FaIcon(
                      FontAwesomeIcons.cartShopping,
                      size: 18,
                    ),
                  ),
                  title: const Text('Giỏ hàng'),
                ),
                SalomonBottomBarItem(
                  icon: const FaIcon(
                    FontAwesomeIcons.solidUser,
                    size: 18,
                  ),
                  title: const Text('Tài khoản'),
                ),
              ],
            ),
          );
        } else if (state is MainLoadingState) {
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
                      '0',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    badgeStyle: BadgeStyle(
                      padding: EdgeInsets.all(4),
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.solidMessage,
                      size: 18,
                    ),
                  ),
                  title: const Text('Tin nhắn'),
                ),
                SalomonBottomBarItem(
                  icon: const Badge(
                    badgeContent: Text(
                      '0',
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
                    FontAwesomeIcons.solidUser,
                    size: 18,
                  ),
                  title: const Text('Tài khoản'),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text('Something went wrong.'),
          );
        }
      },
    );
  }
}
