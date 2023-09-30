import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:study_final/features/notifications/view_models/notification_view_model.dart';
import 'package:study_final/features/settings/models/setting_model.dart';
import 'package:study_final/features/settings/view_models/setting_view_model.dart';
import 'package:study_final/firebase_options.dart';
import 'package:study_final/routers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(SettingModelAdapter());
  await Hive.openBox<SettingModel>("settings");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(const ProviderScope(child: FinalStudyApp()));
}

class FinalStudyApp extends ConsumerWidget {
  const FinalStudyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(notificationProvider);
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      themeMode:
          ref.watch(settingsProvider).isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepOrange.shade100,
        ),
        scaffoldBackgroundColor: Colors.deepOrange.shade100,
        colorSchemeSeed: Colors.deepOrange,
        textTheme: GoogleFonts.signikaTextTheme(
          ThemeData(brightness: Brightness.light).textTheme,
        ),
        brightness: Brightness.light,
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.deepOrange.shade100,
          indicatorColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.black,
        textTheme: GoogleFonts.signikaTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
        brightness: Brightness.dark,
      ),
    );
  }
}
