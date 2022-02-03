import 'package:rapid_react_scouting/models/teamstats.dart';
import 'package:rapid_react_scouting/models/tournament.dart';

import 'package:json_annotation/json_annotation.dart';

part 'leaderboard.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Leaderboard {
  Tournament tournament;
  List<TeamStats> teamStats = [];

  Leaderboard(this.tournament) {
    for (var m in tournament.matches) {
      for (var t in m.teams) {
        int i = teamStats.indexWhere((element) => element.team == t);
        if (i != -1) {
          teamStats[i].matches.add(m);
        } else {
          teamStats.add(TeamStats(t));
        }
      }
    }

    for (var ts in teamStats) {
      ts.calculateRankingPoints();
    }
    sortByRP();
  }

  void sortByRP() {
    teamStats.sort((a, b) {
      if (a.rankingPoints > b.rankingPoints) {
        return 1;
      } else if (a .rankingPoints < b.rankingPoints) {
        return -1;
      } else {
        return 0;
      }
    });
  }

  void sortByPointsPerMatch() {
    teamStats.sort((a, b) {
      if (a.pointsPerMatch > b.pointsPerMatch) {
        return 1;
      } else if (a .pointsPerMatch < b.pointsPerMatch) {
        return -1;
      } else {
        return 0;
      }
    });
  }

  factory Leaderboard.fromJson(Map<String, dynamic> json) =>
    _$LeaderboardFromJson(json);
  Map<String, dynamic> toJson() => _$LeaderboardToJson(this);
}