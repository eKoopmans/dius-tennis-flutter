import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DiUS Tennis',
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xFF21366D,
          const {
            50 : const Color.fromRGBO(33, 54, 109, .1),
            100 : const Color.fromRGBO(33, 54, 109, .2),
            200 : const Color.fromRGBO(33, 54, 109, .3),
            300 : const Color.fromRGBO(33, 54, 109, .4),
            400 : const Color.fromRGBO(33, 54, 109, .5),
            500 : const Color.fromRGBO(33, 54, 109, .6),
            600 : const Color.fromRGBO(33, 54, 109, .7),
            700 : const Color.fromRGBO(33, 54, 109, .8),
            800 : const Color.fromRGBO(33, 54, 109, .9),
            900 : const Color.fromRGBO(33, 54, 109, 1),
          }
        ),
      ),
      home: MyHomePage(title: 'DiUS Tennis in Flutter', p1: 'Player 1', p2: 'Player 2'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.p1, this.p2}) : super(key: key);
  final String title, p1, p2;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<int> _gameScore = [0, 0];
  List<int> _setScore = [0, 0];
  List<int> _matchScore = [0, 0];
  bool _tie = false;

  /// Updates the score by giving a point to the specified player.
  /// @param {number} playerNum - The scoring player's number (0 or 1).
  void _pointWonBy(playerNum) {
    setState(() {
      // Keep scores simple numeric - "translation" happens in getGameScore.
      _gameScore[playerNum]++;

      // Check for victory condition.
      final int minVictory = _tie ? 7 : 4;
      final int scoreDiff = (_gameScore[1] - _gameScore[0]).abs();
      if (_gameScore[playerNum] >= minVictory && scoreDiff >= 2) {
        _gameWonBy(playerNum);
      }
    });
  }

  /// Updates the score by awarding the current game to the specified player.
  /// @param {number} playerNum - The winning player's number (0 or 1).
  void _gameWonBy(playerNum) {
    // Update game and set scores.
    _gameScore = [0, 0];
    _setScore[playerNum]++;

    // Check for victory condition.
    if (_setScore[playerNum] >= 6) {
      final int scoreDiff = (_setScore[1] - _setScore[0]).abs();
      if (_tie || scoreDiff >= 2) {
        _setWonBy(playerNum);
      } else if (scoreDiff == 0) {
        _tie = true;
      }
    }
  }

  /// Updates the score by awarding the current set to the specified player.
  /// @param {number} playerNum - The winning player's number (0 or 1).
  void _setWonBy(playerNum) {
    // Update set and match scores, and reset tie flag.
    // Note: This is undefined behaviour according to the assignment.
    _setScore = [0, 0];
    _matchScore[playerNum]++;
    _tie = false;
  }

  /// Resets the game, set, and match scores.
  void _reset() {
    setState(() {
      _gameScore = [0, 0];
      _setScore = [0, 0];
      _matchScore = [0, 0];
      _tie = false;
    });
  }

  /// Gets the game's current score, formatted as a string. Special cases for Deuce and Advantage.
  /// @return {string} The current game score.
  _getGameScore() {
    // Handle tie special case.
    if (_tie) {
      return _gameScore.join('-');
    }

    // Handle deuce and advantage state.
    final bool atLeast3 = _gameScore.every((v) => v >= 3);
    if (atLeast3) {
      if (_gameScore[0] == _gameScore[1]) {
        return 'Deuce';
      } else if (_gameScore[0] > _gameScore[1]) {
        return 'Advantage ' + widget.p1;
      } else {
        return 'Advantage ' + widget.p2;
      }
    }

    // Default score behaviour, using 0, 15, 30, 40.
    const List<int> scoreMap = [0, 15, 30, 40];
    return _gameScore.map((v) => scoreMap[v]).join('-');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _myContainer('Match Score', _myText('${_matchScore[0]}-${_matchScore[1]}')),
            _myContainer('Set Score', _myText('${_setScore[0]}-${_setScore[1]}')),
            _myContainer('Game Score', _myText(_getGameScore())),
            _myContainer(
              'Point Won By:',
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {_pointWonBy(0);},
                    child: Text('${widget.p1}'),
                    color: const Color(0xFF31b8e8),
                  ),
                  RaisedButton(
                    onPressed: () {_pointWonBy(1);},
                    child: Text('${widget.p2}'),
                    color: const Color(0xFF31b8e8),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _reset,
        child: Icon(Icons.refresh),
      )
    );
  }
}

Widget _myContainer(String heading, Widget content) {
  return Container(
    margin: const EdgeInsets.all(15),
    child: Column(
      children: <Widget>[
        Text(
          heading,
          style: TextStyle(fontSize: 30),
        ),
        content,
      ],
    ),
  );
}

Widget _myText(String text) {
  return Text(
    text,
    style: TextStyle(fontSize: 20),
  );
}