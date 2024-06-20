import 'dart:convert';

class UserRanking {
  final String id;
  final int counter;

  UserRanking({required this.id, required this.counter});

  @override
  String toString() {
    return 'UserRanking(id: $id, counter: $counter)';
  }

  factory UserRanking.fromJson(String source) =>
      UserRanking.fromMap(jsonDecode(source));
  factory UserRanking.fromMap(Map<String, dynamic> map) {
    return UserRanking(id: map["id"], counter: map["counter"]);
  }

  String toJson() => jsonEncode(toMap());
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({"id": id});
    result.addAll({"counter": counter});
    return result;
  }

  UserRanking copyWith({String? id, int? counter}) {
    return UserRanking(id: id ?? this.id, counter: counter ?? this.counter);
  }
}
