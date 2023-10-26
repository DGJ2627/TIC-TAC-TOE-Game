
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Gautam extends StatefulWidget {
  const Gautam({super.key});

  @override
  State<Gautam> createState() => _GautamState();
}

class _GautamState extends State<Gautam> {
  bool ohTurn = true; // the first player o
  List<String> displayExOh = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  int ohscore = 0;
  int exscore = 0;
  int filledBoxes = 0;

  var myTextStyle = const TextStyle(fontSize: 30, color: Colors.white);

  static var myNewFont = GoogleFonts.pressStart2p(textStyle: const TextStyle(color: Colors.white,letterSpacing: 3),);
  static var myNewFontWhite = GoogleFonts.pressStart2p(textStyle: const TextStyle(color: Colors.white,letterSpacing: 3),);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Player X", style: myNewFontWhite),
                          const SizedBox(height: 10,),
                          Text(ohscore.toString(), style: myNewFontWhite),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Player O", style: myNewFontWhite),
                          const SizedBox(height: 10,),
                          Text(exscore.toString(), style: myNewFontWhite),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _tapped(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade700),
                    ),
                    child: Center(
                      child: Text(
                        // index.toString(),
                        displayExOh[index],
                        style:
                        const TextStyle(color: Colors.white, fontSize: 60),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 50,),
          Expanded(
            child: Container(
              child: Text(
                'TIC TAC TOE',
                style: myNewFontWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (ohTurn && displayExOh[index] == '') {
        displayExOh[index] = 'O';
        filledBoxes += 1;
      } else if (!ohTurn && displayExOh[index] == '') {
        displayExOh[index] = 'X';
        filledBoxes += 1;
      }

      ohTurn = !ohTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    //check 1 row
    if (displayExOh[0] == displayExOh[1] &&
        displayExOh[0] == displayExOh[2] &&
        displayExOh[0] != '') {
      _showWinDialog(displayExOh[0]);
    }

    //check 2 row
    if (displayExOh[3] == displayExOh[4] &&
        displayExOh[3] == displayExOh[5] &&
        displayExOh[3] != '') {
      _showWinDialog(displayExOh[3]);
    }

    //check 3 row
    if (displayExOh[6] == displayExOh[7] &&
        displayExOh[6] == displayExOh[8] &&
        displayExOh[6] != '') {
      _showWinDialog(displayExOh[6]);
    }

    //check 1 Column
    if (displayExOh[0] == displayExOh[3] &&
        displayExOh[0] == displayExOh[6] &&
        displayExOh[0] != '') {
      _showWinDialog(displayExOh[0]);
    }

    //check 2 Column
    if (displayExOh[1] == displayExOh[4] &&
        displayExOh[1] == displayExOh[7] &&
        displayExOh[1] != '') {
      _showWinDialog(displayExOh[1]);
    }

    //check 3 Column
    if (displayExOh[2] == displayExOh[5] &&
        displayExOh[2] == displayExOh[8] &&
        displayExOh[2] != '') {
      _showWinDialog(displayExOh[2]);
    }

    //check 2 diagonal
    if (displayExOh[6] == displayExOh[4] &&
        displayExOh[6] == displayExOh[2] &&
        displayExOh[6] != '') {
      _showWinDialog(displayExOh[6]);
    }

    //check 3 diagonal
    if (displayExOh[0] == displayExOh[4] &&
        displayExOh[0] == displayExOh[8] &&
        displayExOh[0] != '') {
      _showWinDialog(displayExOh[0]);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showDrawDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'DRAW',
            style: TextStyle(
                fontSize: 40, color: Colors.red, fontWeight: FontWeight.bold),
          ),
          actions: [
            // TextButton(onPressed: _clearboard, child: const Text("Play Again"),),
            TextButton(
              onPressed: () {
                _clearboard();
                Navigator.of(context).pop();
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  void _showWinDialog(String winner) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'WINNER Is :$winner',
            style: const TextStyle(
                fontSize: 40, color: Colors.red, fontWeight: FontWeight.bold),
          ),
          actions: [
            // TextButton(onPressed: _clearboard, child: const Text("Play Again"),),
            TextButton(
              onPressed: () {
                _clearboard();
                Navigator.of(context).pop();
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );

    if (winner == 'O') {
      ohscore += 1;
    } else if (winner == 'X') {
      exscore += 1;
    }
  }

  void _clearboard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayExOh[i] = '';
      }
    });

    filledBoxes = 0;
  }
}