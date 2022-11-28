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
    apiKey: 'AIzaSyBwCWRQa3BT-Pd3sdm_IbjCNtqooc1k0iw',
    appId: '1:867988330689:web:e7a3d5d7be7ba0e5121c40',
    messagingSenderId: '867988330689',
    projectId: 'meet-x-df6f4',
    authDomain: 'meet-x-df6f4.firebaseapp.com',
    storageBucket: 'meet-x-df6f4.appspot.com',
    measurementId: 'G-SGZ68HLY6Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBuLiHlgltF-UGCAQkgY62M580wKLey_Jc',
    appId: '1:867988330689:android:764a6703371495fc121c40',
    messagingSenderId: '867988330689',
    projectId: 'meet-x-df6f4',
    storageBucket: 'meet-x-df6f4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAs4iEPDQ1RzPWl1IspgDi91cDTR4YZ17Q',
    appId: '1:867988330689:ios:03889fa0f06d6143121c40',
    messagingSenderId: '867988330689',
    projectId: 'meet-x-df6f4',
    storageBucket: 'meet-x-df6f4.appspot.com',
    iosClientId: '867988330689-3me042tm2okn65r19tt2fjsivn4aasq5.apps.googleusercontent.com',
    iosBundleId: 'com.example.meetx',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAs4iEPDQ1RzPWl1IspgDi91cDTR4YZ17Q',
    appId: '1:867988330689:ios:03889fa0f06d6143121c40',
    messagingSenderId: '867988330689',
    projectId: 'meet-x-df6f4',
    storageBucket: 'meet-x-df6f4.appspot.com',
    iosClientId: '867988330689-3me042tm2okn65r19tt2fjsivn4aasq5.apps.googleusercontent.com',
    iosBundleId: 'com.example.meetx',
  );
}