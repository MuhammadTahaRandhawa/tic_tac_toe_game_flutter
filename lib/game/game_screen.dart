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
    final Uri url = Uri.parse('https://www.google.com');
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
                  fit: BoxFit.fill)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                ElevatedButton(
                    onPressed: _launchURL, child: const Text("@taha_dev")),
                const GameBoard(),
                Text(
                  "Players",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                ),
                Consumer<GameProvider>(
                  builder: (context, value, child) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: value.player1Controller,
                          style: const TextStyle().copyWith(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.edit),
                              border: InputBorder.none,
                              hintText: "Player 1",
                              hintStyle: const TextStyle().copyWith(
                                color: Colors.white,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 40, // You can adjust the height as needed
                        child: VerticalDivider(
                          width:
                              40, // This width only affects the spacing around the divider
                          thickness: 2, // Adjust the thickness as needed
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: value.player2Controller,
                          style: const TextStyle().copyWith(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.edit),
                              border: InputBorder.none,
                              hintText: "Player 2",
                              hintStyle: const TextStyle().copyWith(
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
