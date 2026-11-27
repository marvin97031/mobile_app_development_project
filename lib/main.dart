import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'services/notification_service.dart';
import 'services/storage_service.dart';

final ValueNotifier<bool> darkMode = ValueNotifier(false);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.instance.init();
  await NotificationService.instance.init();
  darkMode.value = StorageService.instance.darkMode;
  runApp(const SmakBookApp());
}

class SmakBookApp extends StatelessWidget {
  const SmakBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: darkMode,
      builder: (context, isDark, _) => MaterialApp(
        title: 'SmakBook',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorSchemeSeed: Colors.deepOrange),
        darkTheme: ThemeData(
          colorSchemeSeed: Colors.deepOrange,
          brightness: Brightness.dark,
        ),
        themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
        home: StorageService.instance.currentUser == null
            ? const LoginScreen()
            : const HomeScreen(),
      ),
    );
  }
}
