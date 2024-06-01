import 'dart:convert';

enum Tag { imt101, imt102, ipwa01, ipwa02 }

class QuestionCard {
  final String id;
  final Tag tag;
  final String author;
  final String question;
  final Map<String, bool> options;

  QuestionCard(
      {required this.id,
      required this.tag,
      required this.author,
      required this.question,
      required this.options});

  @override
  String toString() {
    return 'QuestionCard(id: $id, tag: $tag, author: $author question: $question, options: $options)';
  }

  factory QuestionCard.fromJson(String source) =>
      QuestionCard.fromMap(jsonDecode(source));
  factory QuestionCard.fromMap(Map<String, dynamic> map) {
    return QuestionCard(
        id: map["id"],
        tag: Tag.values[map["tag"]],
        author: map["author"],
        question: map["question"],
        options: Map.from(map["options"])); // prüfen!
  }

  String toJson() => jsonEncode(toMap());
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({"id": id});
    result.addAll({"tag": tag.index});
    result.addAll({"author": author});
    result.addAll({"question": question});
    result.addAll({"options": options});
    return result;
  }

  QuestionCard copyWith({
    String? id,
    Tag? tag,
    String? author,
    String? question,
    Map<String, bool>? options,
  }) {
    return QuestionCard(
        id: id ?? this.id,
        tag: tag ?? this.tag,
        author: author ?? this.author,
        question: question ?? this.question,
        options: options ?? this.options);
  }
}
