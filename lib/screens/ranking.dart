import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizz/data/model/user_ranking.dart';
import 'package:flutter_quizz/data/repositories/firestore_rep.dart';
import 'package:flutter_quizz/widgets/list_error.dart';
import 'package:flutter_quizz/widgets/list_loading.dart';
import 'package:flutter_quizz/widgets/user_ranking_list_loaded.dart';

class Ranking extends StatefulWidget {
  const Ranking({super.key});

  @override
  State<Ranking> createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  late final FirestoreRep firestoreRankingRep;
  late Future<List<UserRanking>> userRankingBuilder;

  @override
  void initState() {
    super.initState();
    firestoreRankingRep = FirestoreRep(
      firestore: FirebaseFirestore.instance,
    );
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
            initialData: const [],
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const ListLoading();
                case ConnectionState.active:
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return UserRankingListLoaded(userRankings: snapshot.data!);
                  } else if (snapshot.hasError) {
                    return const ListError(
                      message: "Error",
                    );
                  } else {
                    return const ListError(message: 'Error2');
                  }
              }
            },
          ),
        )),
      ),
    );
  }
}
