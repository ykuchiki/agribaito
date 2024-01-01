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
    apiKey: 'AIzaSyBcn9TNubdkbcjCp7E2r6FareAGMitocl0',
    appId: '1:780563715048:web:1371ba5524471d8a04ca5d',
    messagingSenderId: '780563715048',
    projectId: 'agribaito',
    authDomain: 'agribaito.firebaseapp.com',
    storageBucket: 'agribaito.appspot.com',
    measurementId: 'G-7ZTC6CC9XX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD2T462E1MlxWA5rTVjwQE15JLzZIKM31E',
    appId: '1:780563715048:android:51ffd58ccb01352004ca5d',
    messagingSenderId: '780563715048',
    projectId: 'agribaito',
    storageBucket: 'agribaito.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyACRT7qSeQLQIDyPtjZubNHylzMZKinzhI',
    appId: '1:780563715048:ios:c1c470e356c4f6db04ca5d',
    messagingSenderId: '780563715048',
    projectId: 'agribaito',
    storageBucket: 'agribaito.appspot.com',
    iosBundleId: 'com.example.agribaito',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyACRT7qSeQLQIDyPtjZubNHylzMZKinzhI',
    appId: '1:780563715048:ios:e530c318ae70a2cf04ca5d',
    messagingSenderId: '780563715048',
    projectId: 'agribaito',
    storageBucket: 'agribaito.appspot.com',
    iosBundleId: 'com.example.agribaito.RunnerTests',
  );
}