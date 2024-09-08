import 'package:flutter/material.dart';
import 'package:xoxgame/Game_Page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController player1controller = TextEditingController();
  TextEditingController player2controller = TextEditingController();

  @override
  void dispose() {
    player1controller.clear();
    player2controller.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF323D5B),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            " Enter Players Names",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: TextField(
              style: TextStyle(
                color: Colors.white,
              ),
              cursorColor: Colors.white,
              controller: player1controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),

                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: TextField(
              style: TextStyle(
                color: Colors.white,
              ),
              cursorColor: Colors.white,
              controller: player2controller,
              decoration: InputDecoration(border: OutlineInputBorder(),   focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  enabledBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: () {
              player1controller.text.isEmpty || player2controller.text.isEmpty
                  ? SizedBox()
                  : Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => Gamepage(
                          player1: player1controller.text,
                          player2: player2controller.text)));
            },
            child: Container(
              width: 150,
              height: 60,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6))),
              child: const Text(
                "Reset Game",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
