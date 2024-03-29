// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyADDkJmQ16Pl4QFTpHqd-wrJizWGWxAmdM',
    appId: '1:323405570637:web:6a54d4d6c53aaa4c3cf204',
    messagingSenderId: '323405570637',
    projectId: 'da1-bookstore',
    authDomain: 'da1-bookstore.firebaseapp.com',
    storageBucket: 'da1-bookstore.appspot.com',
    measurementId: 'G-X454FQS5VD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBwq2MXpVZ9TIq2ENtfsOoSKAzumKj3Htc',
    appId: '1:323405570637:android:64d5eaf77672572f3cf204',
    messagingSenderId: '323405570637',
    projectId: 'da1-bookstore',
    storageBucket: 'da1-bookstore.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDH5CH5fx80n91HsSxytQIZunO2UL1X5xM',
    appId: '1:323405570637:ios:f10ba74f294abb423cf204',
    messagingSenderId: '323405570637',
    projectId: 'da1-bookstore',
    storageBucket: 'da1-bookstore.appspot.com',
    iosClientId: '323405570637-eo3a3iolu0kche4iuir6tensdm3oks51.apps.googleusercontent.com',
    iosBundleId: 'com.example.bookStore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDH5CH5fx80n91HsSxytQIZunO2UL1X5xM',
    appId: '1:323405570637:ios:f10ba74f294abb423cf204',
    messagingSenderId: '323405570637',
    projectId: 'da1-bookstore',
    storageBucket: 'da1-bookstore.appspot.com',
    iosClientId: '323405570637-eo3a3iolu0kche4iuir6tensdm3oks51.apps.googleusercontent.com',
    iosBundleId: 'com.example.bookStore',
  );
}
