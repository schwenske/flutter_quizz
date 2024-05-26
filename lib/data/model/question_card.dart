import 'dart:convert';

class QuestionCard {
  final String id;
  final String question;
  final Map<String, bool> options;

  QuestionCard(
      {required this.id, required this.question, required this.options});

  @override
  String toString() {
    return 'QuestionCard(id: $id, question: $question, options: $options)';
  }

  String toJson() => jsonEncode(toMap());
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({"id": id});
    result.addAll({"question": question});
    result.addAll({"options": options});
    return result;
  }
}
