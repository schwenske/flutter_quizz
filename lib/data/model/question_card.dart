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
