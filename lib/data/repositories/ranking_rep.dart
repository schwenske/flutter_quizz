import 'dart:async';
import 'package:flutter_quizz/data/model/user_ranking.dart';

/// Abstract class defining the contract for a ranking repository.
/// This class outlines the methods that any implementation of a ranking
/// repository must provide.
abstract class RankingRep {
  /// Adds a new user ranking to the repository.
  ///
  /// Returns a future that completes when the user ranking has been added.
  FutureOr<void> addUserRanking(UserRanking userRanking);
}
