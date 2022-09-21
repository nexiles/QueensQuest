
import 'package:flutter/cupertino.dart';

class Queen {
  final int id;
  final String name;
  final String quote;
  final bool winner;
  final String imageUrl;

  Queen(this.id, this.name, this.quote, this.winner, this.imageUrl);

  factory Queen.fromJson(Map<String, dynamic> json) {
    var imageUrl = json["image_url"];
    return Queen(
        json["id"],
        json["name"],
        json["quote"],
        json["winner"],
        imageUrl != null ? imageUrl : "no image"
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'quote': quote,
      'winner': winner,
      'image_url': imageUrl
    };
  }
}
