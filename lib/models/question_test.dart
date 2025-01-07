class QuestionTestModel {
  int? id;
  String? content;
  String? answerZero;
  String? answerOne;
  String? answerTwo;
  String? answerThree;
  String? answerFour;

  QuestionTestModel({
    this.id,
    this.content,
    this.answerZero,
    this.answerOne,
    this.answerTwo,
    this.answerThree,
    this.answerFour,
  });

  QuestionTestModel.fromJson(Map<dynamic, dynamic>? map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    content = map['content'];
    answerZero = map['answer_zero'];
    answerOne = map['answer_one'];
    answerTwo = map['answer_two'];
    answerThree = map['answer_three'];
    answerFour = map['answer_four'];
  }
}
