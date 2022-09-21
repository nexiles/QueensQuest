import 'dart:convert';

import 'package:flutter/material.dart';
import 'queenList.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:queens_quest/queen.dart';
import 'package:english_words/english_words.dart';

late final Logger logger;

void main() {
  logger = Logger();
  runApp(const QueensQuest());
}

class QueensQuest extends StatelessWidget {
  const QueensQuest({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Queens Quest',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.pink,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/queensCrown.png',
                fit: BoxFit.contain,
                 height: 32,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: const Text('Queens Quest'),
              ),
            ],

          ),
        ),
        body: const Center(
          child: QueenList(),
        ),
      ),
      // home: const MyHomePage(title: 'Queens Quest'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: const Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: QueenList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchQueens,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // https://docs.flutter.dev/cookbook/networking/background-parsing
  Future<List<Queen>> fetchQueens() async {
    final response = await http
        .get(Uri.parse('http://www.nokeynoshade.party/api/queens'));
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    var queensList = parsed.map<Queen>((json) => Queen.fromJson(json)).toList();
    queensList.forEach((queen) => logger.i(jsonEncode(queen)));
    return queensList;
  }

  Future<Queen> fetchQueenById(int id) async {
    final response = await http
        .get(Uri.parse('http://www.nokeynoshade.party/api/queens/${id}'));
    return Queen.fromJson(jsonDecode(response.body));
  }

}

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}


class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider(); /*2*/
          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return ListTile(
            title: Text(
              _suggestions[index].asPascalCase,
              style: _biggerFont
            ),
          );
        }
    );

  }


}
