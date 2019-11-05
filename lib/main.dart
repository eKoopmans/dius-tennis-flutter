import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DiUS Tennis',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
            Text('Match Score'),
            Text('0-0'),
            Text('Set Score'),
            Text('0-0'),
            Text('Game Score'),
            Text('0-0'),
            Text('Point Won By:'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {},
                  child: Text('${widget.p1}'),
                ),
                RaisedButton(
                  onPressed: () {},
                  child: Text('${widget.p2}'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
