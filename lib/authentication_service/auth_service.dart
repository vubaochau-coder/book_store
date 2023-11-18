import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/core/constant/firebase_collections.dart';
import 'package:book_store/screens/init_profile/init_profile_page.dart';
import 'package:book_store/screens/login_register/auth_page.dart';
import 'package:book_store/main.dart';
import 'package:book_store/screens/cart/bloc/cart_bloc.dart';
import 'package:book_store/screens/notification/bloc/notification_bloc.dart';
import 'package:book_store/screens/profile/bloc/feedback_count_bloc.dart';
import 'package:book_store/screens/profile/bloc/user_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  handleAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(FirebaseCollections.user)
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data?.data() != null) {
                BlocProvider.of<CartBloc>(context).add(CartLoadingEvent());
                BlocProvider.of<UserBloc>(context).add(UserLoadingEvent());
                BlocProvider.of<FeedbackCountBloc>(context)
                    .add(FeedbackCountLoadingEvent());
                BlocProvider.of<NotificationBloc>(context)
                    .add(NotificationLoadingEvent());
                return const RootPage();
              } else {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: AppColors.themeColor,
                    child: Center(
                      child: Image.asset(
                        "images/logo_trans_crop.png",
                        width: 120,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                }
                return const InitProfilePage();
              }
            },
          );
        } else {
          return const AuthenticationPage();
        }
      },
    );
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
      scopes: <String>[
        'email',
        'https://www.googleapis.com/auth/userinfo.profile',
      ],
    ).signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    return;
  }

  signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e.message);
    }
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }
}
