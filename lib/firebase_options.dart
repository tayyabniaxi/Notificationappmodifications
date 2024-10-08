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
    apiKey: 'AIzaSyDXnhCvl9-Px14vD9EOr55NF1uhy3u9gIc',
    appId: '1:360662491445:web:6ba5c7024f7e85b1e8ac7c',
    messagingSenderId: '360662491445',
    projectId: 'wallpaper-app-a0667',
    authDomain: 'wallpaper-app-a0667.firebaseapp.com',
    storageBucket: 'wallpaper-app-a0667.appspot.com',
    measurementId: 'G-3W5LCPQ0EE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCYCrrgHJ77t5QV_HBsTZh7hpPMFN5wOpw',
    appId: '1:360662491445:android:d6e660377f95861fe8ac7c',
    messagingSenderId: '360662491445',
    projectId: 'wallpaper-app-a0667',
    storageBucket: 'wallpaper-app-a0667.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyChAl4NNJnOIpQeVnBegY4m_W4mJu-xAsE',
    appId: '1:360662491445:ios:c6d064b97a1430e4e8ac7c',
    messagingSenderId: '360662491445',
    projectId: 'wallpaper-app-a0667',
    storageBucket: 'wallpaper-app-a0667.appspot.com',
    iosBundleId: 'com.example.myWallpaperApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyChAl4NNJnOIpQeVnBegY4m_W4mJu-xAsE',
    appId: '1:360662491445:ios:c6d064b97a1430e4e8ac7c',
    messagingSenderId: '360662491445',
    projectId: 'wallpaper-app-a0667',
    storageBucket: 'wallpaper-app-a0667.appspot.com',
    iosBundleId: 'com.example.myWallpaperApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDXnhCvl9-Px14vD9EOr55NF1uhy3u9gIc',
    appId: '1:360662491445:web:1628bc9f7c669615e8ac7c',
    messagingSenderId: '360662491445',
    projectId: 'wallpaper-app-a0667',
    authDomain: 'wallpaper-app-a0667.firebaseapp.com',
    storageBucket: 'wallpaper-app-a0667.appspot.com',
    measurementId: 'G-8S6FVBEDMR',
  );
}
