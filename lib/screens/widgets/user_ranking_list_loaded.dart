import "package:flutter/material.dart";
import "package:flutter_quizz/data/model/user_ranking.dart";

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
            userRankings[index].id,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          tileColor: Colors.purple[50],
          subtitle: Column(
            children: [
              Text('${userRankings[index].counter}',
                  style: TextStyle(color: Colors.green[800])),
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
