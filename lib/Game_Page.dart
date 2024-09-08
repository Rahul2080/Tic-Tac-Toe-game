import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'Home.dart';

class Gamepage extends StatefulWidget {
  final String player1;
  final String player2;

  const Gamepage({super.key, required this.player1, required this.player2});

  @override
  State<Gamepage> createState() => _GamepageState();
}

class _GamepageState extends State<Gamepage> {
  late List<List<String>> board;
  late String currentplayer;
  late String winner;
  late bool gameover;

  @override
  void initState() {
    super.initState();
    resetGame();
  }

  void resetGame() {
    setState(() {
      board = List.generate(3, (_) => List.generate(3, (_) => ""));
      currentplayer = "x";
      winner = "";
      gameover = false;
    });
  }

  void makeMove(int row, int col) {
    if (board[row][col] != "" || gameover) {
      return;
    }

    setState(() {
      board[row][col] = currentplayer;
      checkWinner();

      if (!gameover) {
        currentplayer = currentplayer == "x" ? "O" : "x";
      }
    });
  }

  void checkWinner() {
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == currentplayer &&
          board[i][1] == currentplayer &&
          board[i][2] == currentplayer) {
        winner = currentplayer;
        gameover = true;
      } else if (board[0][i] == currentplayer &&
          board[1][i] == currentplayer &&
          board[2][i] == currentplayer) {
        winner = currentplayer;
        gameover = true;
      }
    }

    if (board[0][0] == currentplayer &&
        board[1][1] == currentplayer &&
        board[2][2] == currentplayer) {
      winner = currentplayer;
      gameover = true;
    } else if (board[0][2] == currentplayer &&
        board[1][1] == currentplayer &&
        board[2][0] == currentplayer) {
      winner = currentplayer;
      gameover = true;
    }

    if (!gameover && !board.any((row) => row.any((cel) => cel == ""))) {
      gameover = true;
      winner = "It's a Tie";
    }

    if (gameover) {
      AwesomeDialog(
        context: context,
        dialogType:
            winner == "It's a Tie" ? DialogType.info : DialogType.success,
        animType: AnimType.rightSlide,
        btnOkText: "Play Again",
        title: winner == "x"
            ? "${widget.player1} Won!"
            : winner == "O"
                ? "${widget.player2} Won!"
                : "It's a Tie",
        btnOkOnPress: () {
          resetGame();
        },
      )..show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF323D5B),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Turn: ",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                Text(
                  currentplayer == "x"
                      ? "${widget.player1}  ($currentplayer)"
                      : "${widget.player2} ($currentplayer)",
                  style: TextStyle(
                    fontSize: 25,
                    color: currentplayer == "x" ? Color(0xFFE25041) : Color(0xFF1CBD9E),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Container(
              decoration: BoxDecoration(
                color:Color(0xFF5F6B84),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(5),
              child: GridView.builder(
                itemCount: 9,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  int row = index ~/ 3;
                  int col = index % 3;
                  return GestureDetector(
                    onTap: () => makeMove(row, col),
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color:Color(0xFF0E1E3A),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          board[row][col],
                          style: TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            color: board[row][col] == "x"
                                ?  Color(0xFFE25041)
                                :Color(0xFF1CBD9E),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: resetGame,
                  child: Container(
                    width: 150,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text(
                      "Reset Game",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 40),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => Home()),
                        (route) => (false));
                  },
                  child: Container(
                    width: 150,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text(
                      "Restart Game",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
