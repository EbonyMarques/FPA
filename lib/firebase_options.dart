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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB_NYhA77K8kWSjOJJ9x_02d3t19LpKxpQ',
    appId: '1:976491269953:web:8f99f8ad16534b0ee91bc0',
    messagingSenderId: '976491269953',
    projectId: 'otimizador-academico',
    authDomain: 'otimizador-academico.firebaseapp.com',
    storageBucket: 'otimizador-academico.appspot.com',
    measurementId: 'G-P9MK2V9MCD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC-8-QMhYLp7lVLnoDmBpctsDWnO6vj02A',
    appId: '1:976491269953:android:3fb32f5098b3a9c7e91bc0',
    messagingSenderId: '976491269953',
    projectId: 'otimizador-academico',
    storageBucket: 'otimizador-academico.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBt_pI3hY_pCsLm1TMVy1b4Wgp0GoGS9Qc',
    appId: '1:976491269953:ios:be7b143c0e36bbebe91bc0',
    messagingSenderId: '976491269953',
    projectId: 'otimizador-academico',
    storageBucket: 'otimizador-academico.appspot.com',
    iosClientId: '976491269953-e20roilj65ar9niurco8eu4bplhhk9l2.apps.googleusercontent.com',
    iosBundleId: 'com.example.otimizadorAcademico',
  );
}
