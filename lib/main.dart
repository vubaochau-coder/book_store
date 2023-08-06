import 'package:badges/badges.dart' as badge;
import 'package:book_store/authentication_service/auth_service.dart';
import 'package:book_store/bloc/cart_count_bloc.dart';
import 'package:book_store/screens/Checkout/bloc/checkout_bloc.dart';
import 'package:book_store/screens/address_setting/bloc/address_bloc.dart';
import 'package:book_store/screens/cart/bloc/cart_bloc.dart';
import 'package:book_store/screens/cart/ui/cart_page.dart';
import 'package:book_store/screens/categories/child/bloc/child_bloc.dart';
import 'package:book_store/screens/categories/comic/bloc/comic_bloc.dart';
import 'package:book_store/screens/categories/literature/bloc/literature_bloc.dart';
import 'package:book_store/screens/categories/others/bloc/other_bloc.dart';
import 'package:book_store/screens/categories/science/bloc/science_bloc.dart';
import 'package:book_store/screens/categories/sgk/bloc/sgk_bloc.dart';
import 'package:book_store/screens/edit_password/bloc/edit_pass_bloc.dart';
import 'package:book_store/screens/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:book_store/screens/home/bloc/home_bloc.dart';
import 'package:book_store/screens/home/ui/home_page.dart';
import 'package:book_store/screens/my_favorite/bloc/favorite_bloc.dart';
import 'package:book_store/screens/my_feedback/bloc/my_feedback_bloc.dart';
import 'package:book_store/screens/notification/bloc/notification_bloc.dart';
import 'package:book_store/screens/notification/ui/notification_page.dart';
import 'package:book_store/screens/order_bill/bloc/bill_bloc.dart';
import 'package:book_store/screens/product_detail/bloc/product_bloc.dart';
import 'package:book_store/screens/product_feedback/bloc/product_feedback_bloc.dart';
import 'package:book_store/screens/profile/bloc/feedback_count_bloc.dart';
import 'package:book_store/screens/profile/bloc/user_bloc.dart';
import 'package:book_store/screens/profile/ui/profile_page.dart';
import 'package:book_store/screens/transaction_status/cancelled/bloc/cancelled_bloc.dart';
import 'package:book_store/screens/transaction_status/delivered/bloc/delivered_bloc.dart';
import 'package:book_store/screens/transaction_status/delivering/bloc/delivering_bloc.dart';
import 'package:book_store/screens/transaction_status/unconfirmed/bloc/unconfirmed_bloc.dart';
import 'package:book_store/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'bloc/noti_count_bloc.dart';
import 'screens/search/bloc/search_bloc.dart';
import 'screens/transaction_status/await_pickup/bloc/await_pickup_bloc.dart';

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
        BlocProvider(create: (context) => CartCountBloc()),
        BlocProvider(create: (context) => NotiCountBloc()),
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
        BlocProvider(create: (context) => MyFeedbackBloc()),
        BlocProvider(create: (context) => ProductFeedbackBloc()),
        BlocProvider(create: (context) => EditProfileBloc()),
        BlocProvider(create: (context) => EditPasswordBloc()),
        BlocProvider(create: (context) => NotificationBloc()),
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
            icon: BlocBuilder<NotiCountBloc, NotiCountState>(
              builder: (context, state) {
                if (state is NotiCountLoadingSuccessfulState) {
                  return badge.Badge(
                    showBadge: state.notiCount > 0,
                    badgeContent: Text(
                      state.notiCount.toString(),
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
                } else {
                  return const badge.Badge(
                    showBadge: false,
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
                  );
                }
              },
            ),
            title: const Text('Thông báo'),
          ),
          SalomonBottomBarItem(
            icon: BlocBuilder<CartCountBloc, CartCountState>(
              builder: (context, state) {
                if (state is CartCountLoadingSuccessfulState) {
                  return badge.Badge(
                    showBadge: state.cartNumber > 0,
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
                  );
                } else {
                  return const badge.Badge(
                    showBadge: false,
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
                  );
                }
              },
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
  }
}
