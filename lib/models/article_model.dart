class ArticleModel {
  int? id;
  String? title;
  String? content;
  String? category;

  ArticleModel({
    this.id,
    this.title,
    this.content,
    this.category,
  });

  ArticleModel.fromJson(Map<dynamic, dynamic>? map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    title = map['title'];
    content = map['content'];
    category = map['category'];
  }
}
