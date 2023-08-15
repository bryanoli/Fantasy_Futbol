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
    apiKey: 'AIzaSyDA-g9PvAHMVVenjffX5gudRCwbngTMhec',
    appId: '1:380458320117:web:4c1d7057bd49efca4d05bc',
    messagingSenderId: '380458320117',
    projectId: 'fantasyfutbol2023',
    authDomain: 'fantasyfutbol2023.firebaseapp.com',
    storageBucket: 'fantasyfutbol2023.appspot.com',
    measurementId: 'G-LR1B92442X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBkBTr3HNaKSug_uCKsO7EvD7iwG0dbiLk',
    appId: '1:380458320117:android:367cac87c129ac174d05bc',
    messagingSenderId: '380458320117',
    projectId: 'fantasyfutbol2023',
    storageBucket: 'fantasyfutbol2023.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDsEp7Ixnn0LJFLKsL9mobAte2fgblGFOQ',
    appId: '1:380458320117:ios:b10fa056aba1202b4d05bc',
    messagingSenderId: '380458320117',
    projectId: 'fantasyfutbol2023',
    storageBucket: 'fantasyfutbol2023.appspot.com',
    iosClientId: '380458320117-tct7gehgh52bvi2rnu8d59j79svufp2q.apps.googleusercontent.com',
    iosBundleId: 'com.example.fantasyFutbol',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDsEp7Ixnn0LJFLKsL9mobAte2fgblGFOQ',
    appId: '1:380458320117:ios:c5296dcbfe8cab924d05bc',
    messagingSenderId: '380458320117',
    projectId: 'fantasyfutbol2023',
    storageBucket: 'fantasyfutbol2023.appspot.com',
    iosClientId: '380458320117-50c7h6bcih3e5ketsdbrv77s2ne52j88.apps.googleusercontent.com',
    iosBundleId: 'com.example.fantasyFutbol.RunnerTests',
  );
}