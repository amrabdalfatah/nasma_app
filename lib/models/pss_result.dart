class PssResultModel {
  int? id;
  int? userId;
  int? testId;
  int? score;
  String? level;
  String? testDate;

  PssResultModel({
    this.id,
    this.userId,
    this.testId,
    this.score,
    this.level,
    this.testDate,
  });

  PssResultModel.fromJson(Map<dynamic, dynamic>? map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    userId = map['user_id'];
    testId = map['test_id'];
    score = map['score'];
    level = map['level'];
    testDate = map['test_date'];
  }
}
