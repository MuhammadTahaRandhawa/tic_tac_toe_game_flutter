import 'package:flutter/material.dart';
import 'package:myapp/game/game_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const GameScreen(),
          ));
        },
      );
    });
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg_screen.png'),
                fit: BoxFit.fill)),
      ),
    );
  }
}
