import 'package:flutter/cupertino.dart';

class QueenList extends StatefulWidget {
  const QueenList({Key? key}) : super(key: key);

  @override
  State<QueenList> createState() => _QueenListState();
}

class _QueenListState extends State<QueenList> {

  final _list = <String>['adaksd'];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, idx) {
      return Text(_list[0]);
    });
  }
}
