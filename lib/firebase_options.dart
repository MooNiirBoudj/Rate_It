// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyBmGgKYbu9NtBw34NSe1OSq7omwVhuqSeQ',
    appId: '1:44110580903:web:a92bfd52c43bfe3c2f9f82',
    messagingSenderId: '44110580903',
    projectId: 'rateit-df428',
    authDomain: 'rateit-df428.firebaseapp.com',
    storageBucket: 'rateit-df428.firebasestorage.app',
    measurementId: 'G-3DELMSX2DW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCnyS57AanXKY2msDdhkOd6PStwQEbJXzY',
    appId: '1:44110580903:android:d62c34ef8ca810672f9f82',
    messagingSenderId: '44110580903',
    projectId: 'rateit-df428',
    storageBucket: 'rateit-df428.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAIVmoER_EVrkn6jkTzie5Oz5z8JPeMbbY',
    appId: '1:44110580903:ios:bec3a9f7ff1c4ac02f9f82',
    messagingSenderId: '44110580903',
    projectId: 'rateit-df428',
    storageBucket: 'rateit-df428.firebasestorage.app',
    iosBundleId: 'com.example.rateIt',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAIVmoER_EVrkn6jkTzie5Oz5z8JPeMbbY',
    appId: '1:44110580903:ios:bec3a9f7ff1c4ac02f9f82',
    messagingSenderId: '44110580903',
    projectId: 'rateit-df428',
    storageBucket: 'rateit-df428.firebasestorage.app',
    iosBundleId: 'com.example.rateIt',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBmGgKYbu9NtBw34NSe1OSq7omwVhuqSeQ',
    appId: '1:44110580903:web:25ca7dc839e828012f9f82',
    messagingSenderId: '44110580903',
    projectId: 'rateit-df428',
    authDomain: 'rateit-df428.firebaseapp.com',
    storageBucket: 'rateit-df428.firebasestorage.app',
    measurementId: 'G-R6BP6PVEB4',
  );
}