import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(GetMaterialApp(
    theme: new ThemeData(scaffoldBackgroundColor: const Color.fromRGBO(18, 27, 65, 1.0)),
    home: Choices(),
  ));
//   FirebaseAuth.instance
//       .authStateChanges()
//       .listen((User? user) {
//     if (user == null) {
//       print('User is currently signed out!');
//     } else {
//       print('User is signed in!');
//     }
//   });
//   FirebaseAuth.instance
//       .idTokenChanges()
//       .listen((User? user) {
//     if (user == null) {
//       print('User is currently signed out!');
//     } else {
//       print('User is signed in!');
//     }
//   });
//   FirebaseAuth.instance
//       .userChanges()
//       .listen((User? user) {
//     if (user == null) {
//       print('User is currently signed out!');
//     } else {
//       print('User is signed in!');
//     }
//   });
//   // Disable persistence on web platforms. Must be called on initialization:
//   final auth = FirebaseAuth.instanceFor(app: Firebase.app(), persistence: Persistence.NONE);
// // To change it after initialization, use `setPersistence()`:
//   await auth.setPersistence(Persistence.LOCAL);
}
