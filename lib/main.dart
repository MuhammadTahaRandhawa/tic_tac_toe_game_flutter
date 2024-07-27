import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:myapp/game/game_provider.dart';
import 'package:myapp/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => ChangeNotifierProvider(
        create: (context) => GameProvider(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData().copyWith(
          iconTheme: const IconThemeData().copyWith(color: Colors.white),
          inputDecorationTheme: const InputDecorationTheme()
              .copyWith(suffixIconColor: Colors.white)),
    );
  }
}
