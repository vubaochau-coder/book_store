import 'package:badges/badges.dart' as badge;
import 'package:book_store/AddressSetting/bloc/address_bloc.dart';
import 'package:book_store/Cart/bloc/cart_bloc.dart';
import 'package:book_store/Cart/ui/cart_page.dart';
import 'package:book_store/Category/ChildCategory/bloc/child_bloc.dart';
import 'package:book_store/Category/ComicCategory/bloc/comic_bloc.dart';
import 'package:book_store/Category/LiteratureCategory/bloc/literature_bloc.dart';
import 'package:book_store/Category/OtherCategory/bloc/other_bloc.dart';
import 'package:book_store/Category/SGKCategory/bloc/sgk_bloc.dart';
import 'package:book_store/Category/ScienceCategory/bloc/science_bloc.dart';
import 'package:book_store/ChangePasswordPage/bloc/change_pass_bloc.dart';
import 'package:book_store/ChangeProfilePage/bloc/edit_profile_bloc.dart';
import 'package:book_store/Checkout/bloc/checkout_bloc.dart';
import 'package:book_store/Favorite/bloc/favorite_bloc.dart';
import 'package:book_store/ProductFeedback/bloc/product_feedback_bloc.dart';
import 'package:book_store/UserFeedback/bloc/user_feedback_bloc.dart';
import 'package:book_store/Home/bloc/home_bloc.dart';
import 'package:book_store/OrderBill/bloc/bill_bloc.dart';
import 'package:book_store/ProductDetail/bloc/product_bloc.dart';
import 'package:book_store/Profile/bloc/feedback_count_bloc.dart';
import 'package:book_store/Profile/bloc/user_bloc.dart';
import 'package:book_store/Profile/ui/profile_page.dart';
import 'package:book_store/Notification/tin_nhan_page.dart';
import 'package:book_store/Home/ui/home_page.dart';
import 'package:book_store/Authentication%20Service/auth_service.dart';
import 'package:book_store/SearchPage/bloc/search_bloc.dart';
import 'package:book_store/Transaction/AwaitPickup/bloc/await_pickup_bloc.dart';
import 'package:book_store/Transaction/Cancelled/bloc/cancelled_bloc.dart';
import 'package:book_store/Transaction/Delivered/bloc/delivered_bloc.dart';
import 'package:book_store/Transaction/Delivering/bloc/delivering_bloc.dart';
import 'package:book_store/Transaction/Unconfirmed/bloc/unconfirmed_bloc.dart';
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
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider(create: (context) => MainBloc()),
        BlocProvider(create: (context) => SgkBloc()),
        BlocProvider(create: (context) => LiteratureBloc()),
        BlocProvider(create: (context) => ComicBloc()),
        BlocProvider(create: (context) => ChildBloc()),
        BlocProvider(create: (context) => ScienceBloc()),
        BlocProvider(create: (context) => OtherBloc()),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => CheckoutBloc()),
        BlocProvider(create: (context) => AddressBloc()),
        BlocProvider(create: (context) => BillBloc()),
        BlocProvider(create: (context) => AwaitPickupBloc()),
        BlocProvider(create: (context) => UnconfirmedBloc()),
        BlocProvider(create: (context) => DeliveringBloc()),
        BlocProvider(create: (context) => DeliveredBloc()),
        BlocProvider(create: (context) => CancelledBloc()),
        BlocProvider(create: (context) => SearchBloc()),
        BlocProvider(create: (context) => FavoriteBloc()),
        BlocProvider(create: (context) => FeedbackCountBloc()),
        BlocProvider(create: (context) => UserFeedbackBloc()),
        BlocProvider(create: (context) => ProductFeedbackBloc()),
        BlocProvider(create: (context) => EditProfileBloc()),
        BlocProvider(create: (context) => ChangePassBloc()),
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
    ProfilePage(),
  ];

  final controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        if (state is MainLoadingSuccessfulState) {
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
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInQuint,
                );
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
                  icon: badge.Badge(
                    showBadge: state.messNumber > 0 ? true : false,
                    badgeContent: Text(
                      state.messNumber.toString(),
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
                  ),
                  title: const Text('Thông báo'),
                ),
                SalomonBottomBarItem(
                  icon: badge.Badge(
                    showBadge: state.cartNumber > 0 ? true : false,
                    badgeContent: Text(
                      state.cartNumber.toString(),
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
                  icon: const badge.Badge(
                    showBadge: true,
                    badgeContent: Text(
                      '0',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    badgeStyle: badge.BadgeStyle(
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
                  icon: const badge.Badge(
                    badgeContent: Text(
                      '0',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    badgeStyle: badge.BadgeStyle(
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
