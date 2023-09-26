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
    apiKey: 'AIzaSyDu3amZ6nTe2joX_fOQPr3uzg3zUHdZaQk',
    appId: '1:1050037307292:web:18fb82fc5f65faeda22a59',
    messagingSenderId: '1050037307292',
    projectId: 'nomad-study-final',
    authDomain: 'nomad-study-final.firebaseapp.com',
    storageBucket: 'nomad-study-final.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA4pf44ciOm4qFL4oJDb_jkLL5N8paQLYE',
    appId: '1:1050037307292:android:b40348546bb350c1a22a59',
    messagingSenderId: '1050037307292',
    projectId: 'nomad-study-final',
    storageBucket: 'nomad-study-final.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAh6so77BPLWFgziogjij17nJrI0sywrx0',
    appId: '1:1050037307292:ios:420e934ed7630fb2a22a59',
    messagingSenderId: '1050037307292',
    projectId: 'nomad-study-final',
    storageBucket: 'nomad-study-final.appspot.com',
    iosClientId: '1050037307292-keoppq3ftdpumudfkgt3v3nlutnadco3.apps.googleusercontent.com',
    iosBundleId: 'com.example.studyFinal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAh6so77BPLWFgziogjij17nJrI0sywrx0',
    appId: '1:1050037307292:ios:5090c6e6a6c55ebda22a59',
    messagingSenderId: '1050037307292',
    projectId: 'nomad-study-final',
    storageBucket: 'nomad-study-final.appspot.com',
    iosClientId: '1050037307292-teuc5nen6eaa6pi27im8hhnid48lp2m4.apps.googleusercontent.com',
    iosBundleId: 'com.example.studyFinal.RunnerTests',
  );
}
