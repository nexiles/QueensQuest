import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:queens_quest/queen.dart';

class QueensAPI {
  static final logger = Logger();

  // https://docs.flutter.dev/cookbook/networking/background-parsing
  static Future<List<Queen>> fetchQueens() async {
    final response =
        await http.get(Uri.parse('http://www.nokeynoshade.party/api/queens'));
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    var queensList = parsed.map<Queen>((json) => Queen.fromJson(json)).toList();
    queensList.forEach((queen) => logger.i(jsonEncode(queen)));
    return queensList;
  }

  static Future<Queen> fetchQueenById(int id) async {
    final response = await http
        .get(Uri.parse('http://www.nokeynoshade.party/api/queens/${id}'));
    return Queen.fromJson(jsonDecode(response.body));
  }
}
