import 'package:flutter/material.dart';
import 'package:myapp/game/game_board.dart';
import 'package:myapp/game/game_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _launchURL() async {
    final Uri url = Uri.parse(
        'https://www.linkedin.com/in/muhammad-taha-randhawa-7823a125a/');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg_screen.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                ElevatedButton(
                  onPressed: _launchURL,
                  child:
                      const Text("@taha_dev", style: TextStyle(fontSize: 18)),
                ),
                const GameBoard(),
                Text(
                  "Players",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Consumer<GameProvider>(
                  builder: (context, value, child) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: value.player1Controller,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            suffixIcon:
                                const Icon(Icons.edit, color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: value.currentPlayer == 'X'
                                      ? const Color(0XFFF99D17)
                                      : Colors.white,
                                  width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: value.currentPlayer == 'X'
                                      ? const Color(0XFFF99D17)
                                      : Colors.white,
                                  width: 3),
                            ),
                            hintText: "Player 1",
                            hintStyle: const TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Colors.black54,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                        child: VerticalDivider(
                          width: 40,
                          thickness: 2,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: value.player2Controller,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            suffixIcon:
                                const Icon(Icons.edit, color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: value.currentPlayer == 'O'
                                      ? const Color(0XFFF99D17)
                                      : Colors.white,
                                  width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: value.currentPlayer == 'O'
                                      ? const Color(0XFFF99D17)
                                      : Colors.white,
                                  width: 3),
                            ),
                            hintText: "Player 2",
                            hintStyle: const TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
