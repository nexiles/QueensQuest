import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:queens_quest/queen.dart';

class QueenDetailRoute extends StatelessWidget {
  const QueenDetailRoute({Key? key, this.queen}) : super(key: key);

  final Queen? queen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/queensCrown.png',
              fit: BoxFit.contain,
              height: 32,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(queen!.name),
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(queen!.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                color: Colors.black,
                child: Text(
                  queen!.quote,
                  style: TextStyle(fontSize: 22, color: Colors.white),
                  textAlign: TextAlign.center,
                )),
          )
        ],
      ),
    );
  }
}
