import 'dart:async';
import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:queens_quest/api.dart';
import 'package:logger/logger.dart';
import 'package:queens_quest/queen.dart';
import 'package:english_words/english_words.dart';

import 'detail.dart';

late final Logger logger;

void main() {
  logger = Logger();
  runApp(QueensQuest());
}

class QueensQuest extends StatelessWidget {
  QueensQuest({super.key});

  StreamController<List<Queen>> queenListStreamController =
      StreamController<List<Queen>>();

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/queensCrown.png',
                fit: BoxFit.contain,
                height: 32,
              ),
              GestureDetector(
                  onTap: () {
                    queenListStreamController = StreamController<List<Queen>>();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text('Queens Quest'),
                  )),
            ],
          ),
        ),
        body: Center(
          child: StreamBuilder<List<Queen>>(
            stream: queenListStreamController.stream,
            builder:
                (BuildContext context, AsyncSnapshot<List<Queen>> snapshot) {
              List<Queen>? queens = snapshot.data;
              return queens != null
                  ? _buildContent(context, queens)
                  : AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Fetch Queens',
                          textStyle: const TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink),
                          speed: const Duration(milliseconds: 500),
                        ),
                      ],
                      isRepeatingAnimation: true,
                      pause: const Duration(milliseconds: 1000),
                      displayFullTextOnTap: true,
                    );
            },
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(height: 50.0),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => QueensAPI.fetchQueens()
              .then((queensList) => queenListStreamController.add(queensList)),
          tooltip: 'Fetch Queens',
          child: const Icon(Icons.woman),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
      // home: const MyHomePage(title: 'Queens Quest'),
    );
  }

  Widget _buildContent(BuildContext context, List<Queen> queens) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        padding: const EdgeInsets.all(8),
        itemCount: queens.length,
        itemBuilder: (context, idx) {
          logger.i(queens.length);
          var queen = queens[idx];

          var title;
          if (queen.winner) {
            title = Text(queen.name,
                    style: const TextStyle(fontSize: 18, color: Colors.pink),
                    textAlign: TextAlign.center);
          } else if (queen.imageUrl == "no image") {
            title = Text(queen.name,
                    style: const TextStyle(fontSize: 18, decoration: TextDecoration.lineThrough),
                    textAlign: TextAlign.center);
          } else {
            title = Text(queen.name,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center);
          }


          return ListTile(
            title: title,
            subtitle: queen.quote.isEmpty ? null : Text(queen.quote, textAlign: TextAlign.center),
            onTap: () => _onTapQueen(context, queen.id),
          );
        });
  }

  void _onTapQueen(BuildContext context, int queenId) {
    QueensAPI.fetchQueenById(queenId).then((value) => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QueenDetailRoute(queen: value))));
  }
}
