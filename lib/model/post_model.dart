class PostModel {
  final int? userId;
  final int? it;
  final String? title;
  final String? body;

  PostModel({
    this.userId,
    this.it,
    this.title,
    this.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        userId: json["userId"],
        it: json["it"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "it": it,
        "title": title,
        "body": body,
      };
}
