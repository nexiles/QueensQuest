import 'package:flutter/cupertino.dart';
import 'package:queens_quest/queen.dart';

class QueenDetailRoute extends StatelessWidget {
  const QueenDetailRoute({Key? key, this.queen}) : super(key: key);

  final Queen? queen;
  @override
  Widget build(BuildContext context) {
    return Container(
    decoration:
         BoxDecoration(
             image: DecorationImage(
                        image: NetworkImage(queen!.imageUrl))));
    // return Text(queen?.name != null ? queen!.name : 'null');
  }
}
