import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizz/data/model/user_ranking.dart';

/// Retrieves the currently authenticated user and their display name.
User currentUser = FirebaseAuth.instance.currentUser!;
String myName = currentUser.displayName ?? 'unknown User';
String myId = currentUser.uid;

/// Displays a list of user rankings, highlighting the current user's rank.
class UserRankingListLoaded extends StatelessWidget {
  /// The list of user rankings to be displayed.
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
          // Displays the user's rank (position in the list + 1)
          title: Text(
            '${index + 1}',
            style: const TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          // Highlights the current user's ranking with a green background
          tileColor:
              userRankings[index].id == myId ? Colors.green : Colors.white54,
          subtitle: Column(
            children: [
              // Displays the user's name
              Text(
                userRankings[index].username,
                style: const TextStyle(fontSize: 20),
              ),
              // Displays the user's score
              Text(
                '${userRankings[index].counter}',
                style: const TextStyle(fontSize: 20),
              ),
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
