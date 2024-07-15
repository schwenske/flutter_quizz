import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizz/data/model/user_ranking.dart';
import 'package:flutter_quizz/data/repositories/firestore_rep.dart';
import 'package:flutter_quizz/screens/widgets/list_error.dart';
import 'package:flutter_quizz/screens/widgets/list_loading.dart';
import 'package:flutter_quizz/screens/widgets/user_ranking_list_loaded.dart';

/// Screen to display the user rankings.
class Ranking extends StatefulWidget {
  const Ranking({super.key});

  @override
  State<Ranking> createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  /// Firestore repository instance for accessing user rankings.
  late final FirestoreRep firestoreRankingRep;

  /// Future builder to fetch the user rankings.
  late Future<List<UserRanking>> userRankingBuilder;

  @override
  void initState() {
    super.initState();
    firestoreRankingRep = FirestoreRep(firestore: FirebaseFirestore.instance);
    userRankingBuilder = firestoreRankingRep.getAllUserRankings();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Rangliste",
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: FutureBuilder<List<UserRanking>>(
              future: userRankingBuilder,
              initialData: const [], // Provide an empty list while loading
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const ListLoading(); // Show loading indicator
                  case ConnectionState.active:
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      return UserRankingListLoaded(
                          userRankings: snapshot.data!);
                    } else if (snapshot.hasError) {
                      return const ListError(
                        message: "Error fetching rankings",
                      );
                    } else {
                      return const ListError(message: 'Unknown error');
                    }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
