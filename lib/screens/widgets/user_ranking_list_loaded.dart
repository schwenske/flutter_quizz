import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_quizz/data/model/user_ranking.dart";

User currentUser = FirebaseAuth.instance.currentUser!;
String myName = currentUser.displayName ?? 'unknown User';

class UserRankingListLoaded extends StatelessWidget {
  final List<UserRanking> userRankings;

  const UserRankingListLoaded({
    super.key,
    required this.userRankings,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: userRankings.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            '${index + 1}',
            style: const TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          tileColor: userRankings[index].username == myName
              ? Colors.green
              : Colors.white54,
          subtitle: Column(
            children: [
              Text(userRankings[index].username,
                  style: const TextStyle(
                    fontSize: 20,
                  )),
              Text('${userRankings[index].counter}',
                  style: const TextStyle(fontSize: 20)),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        color: Colors.black,
      ),
    );
  }
}
