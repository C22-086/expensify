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
    apiKey: 'AIzaSyBioqqIVGQoxfx5fyeDC7xl4zIFXACoubs',
    appId: '1:496886854887:web:3885d4a5132cbe30ce1e42',
    messagingSenderId: '496886854887',
    projectId: 'expensify-a0254',
    authDomain: 'expensify-a0254.firebaseapp.com',
    storageBucket: 'expensify-a0254.appspot.com',
    measurementId: 'G-EYQXXPQCN7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBPRIW88OVhNHJ4wRXkJxRrEW4_KCu-Zf8',
    appId: '1:496886854887:android:273404f35f0abcbcce1e42',
    messagingSenderId: '496886854887',
    projectId: 'expensify-a0254',
    storageBucket: 'expensify-a0254.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBa0lXIItB1soLbfmvz0je2vwvyw6QJ9DQ',
    appId: '1:496886854887:ios:f04dc834c795f1a7ce1e42',
    messagingSenderId: '496886854887',
    projectId: 'expensify-a0254',
    storageBucket: 'expensify-a0254.appspot.com',
    iosClientId: '496886854887-8tp85lb9ind8fpdiugo1ei0ul2jsl411.apps.googleusercontent.com',
    iosBundleId: 'com.example.expensify',
  );
}