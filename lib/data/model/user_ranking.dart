import 'dart:convert';

class UserRanking {
  final String id;
  final int counter;
  final String username;

  UserRanking({
    required this.id,
    required this.counter,
    required this.username,
  });

  @override
  String toString() {
    return 'UserRanking(id: $id, counter: $counter)';
  }

  factory UserRanking.fromJson(String source) =>
      UserRanking.fromMap(jsonDecode(source));
  factory UserRanking.fromMap(Map<String, dynamic> map) {
    return UserRanking(
        id: map["id"], counter: map["counter"], username: map["username"]);
  }

  String toJson() => jsonEncode(toMap());
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({"id": id});
    result.addAll({"counter": counter});
    result.addAll({"username": username});
    return result;
  }

  UserRanking copyWith({String? id, int? counter, String? username}) {
    return UserRanking(
        id: id ?? this.id,
        counter: counter ?? this.counter,
        username: username ?? this.username);
  }
}
