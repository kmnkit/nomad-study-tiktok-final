import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      themeMode:
          ref.watch(settingsProvider).isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepOrange,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.black,
      ),
    );
  }
}
