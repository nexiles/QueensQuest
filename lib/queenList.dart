import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:queens_quest/queen.dart';

import 'main.dart';

class QueenList extends StatefulWidget {
  const QueenList({Key? key}) : super(key: key);

  @override
  State<QueenList> createState() => _QueenListState();
}

class _QueenListState extends State<QueenList> {
  @override
  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    fetchQueens().then((value) => _list = value);
  }

  // https://docs.flutter.dev/cookbook/networking/background-parsing
  Future<List<Queen>> fetchQueens() async {
    final response =
        await http.get(Uri.parse('http://www.nokeynoshade.party/api/queens'));
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    var queensList = parsed.map<Queen>((json) => Queen.fromJson(json)).toList();
    queensList.forEach((queen) => logger.i(jsonEncode(queen)));
    return queensList;
  }

  var _list = <Queen>[];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        padding: const EdgeInsets.all(8),
        itemCount: _list.length,
        itemBuilder: (context, idx) {
          logger.i(_list.length);
          return Text(
            _list[idx].name,
            style: const TextStyle(fontSize: 18),
          );
        });
  }
}
