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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC8x-VM1tR5pU2rMXp_-OE8qV1oWSUKKBU',
    appId: '1:87918359587:android:9e10b86d59bbcae9fa2d96',
    messagingSenderId: '87918359587',
    projectId: 'rubberx-f3daf',
    storageBucket: 'rubberx-f3daf.appspot.com',
    databaseURL: 'https://rubberx-f3daf-default-rtdb.asia-southeast1.firebasedatabase.app'
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB1o0PtJoIBXwIp-XVPFmrw7WwSGXDmYgE',
    appId: '1:87918359587:ios:e5b5b56893ee7ffefa2d96',
    messagingSenderId: '87918359587',
    projectId: 'rubberx-f3daf',
    storageBucket: 'rubberx-f3daf.appspot.com',
    iosBundleId: 'com.example.rubberx',
    databaseURL: 'https://rubberx-f3daf-default-rtdb.asia-southeast1.firebasedatabase.app'
  );
}