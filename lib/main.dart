import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:queens_quest/api.dart';
import 'package:logger/logger.dart';
import 'package:queens_quest/queen.dart';
import 'package:english_words/english_words.dart';

late final Logger logger;

void main() {
  logger = Logger();
  runApp(QueensQuest());
}

class QueensQuest extends StatelessWidget {
  QueensQuest({super.key});

  var queensList;

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
        body: Center(
          child: queensList != null ? ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              padding: const EdgeInsets.all(8),
              itemCount: queensList.length,
              itemBuilder: (context, idx) {
                logger.i(queensList.length);
                return Text(
                  queensList[idx].name,
                  style: const TextStyle(fontSize: 18),
                );
              }) : Text("No data"),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(height: 50.0),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            queensList = QueensAPI.fetchQueens();
          },
          tooltip: 'Increment Counter',
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
      // home: const MyHomePage(title: 'Queens Quest'),
    );
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
