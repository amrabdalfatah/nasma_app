class PSSTestModel {
  int? id;
  String? title;
  String? description;

  PSSTestModel({
    this.id,
    this.title,
    this.description,
  });

  PSSTestModel.fromJson(Map<dynamic, dynamic>? map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    title = map['title'];
    description = map['description'];
  }
}
