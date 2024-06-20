import 'dart:async';
import 'package:flutter_quizz/data/model/user_ranking.dart';

abstract class RankingRep {
  FutureOr<void> addUserRanking(UserRanking userRanking);
  FutureOr<void> updateQuestionCard(UserRanking userRanking);
}
