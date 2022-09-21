class Queen {
  final int id;
  final String name;
  final String imageUrl;

  Queen(this.id, this.name, this.imageUrl);

  factory Queen.fromJson(Map<String, dynamic> json) {
    return Queen(json["id"], json["name"], json["image_url"]);
  }

  Map<String, dynamic> toJson() {
       return <String, dynamic>{
      'id': id,
      'name': name,
      'image_url': imageUrl
    };
  }
}
