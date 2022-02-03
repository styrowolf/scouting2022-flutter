import 'package:rapid_react_scouting/models/match.dart';
import 'package:rapid_react_scouting/models/teammatchstats.dart';
import 'package:rapid_react_scouting/models/teamnumber.dart';

import 'package:json_annotation/json_annotation.dart';

part 'teamstats.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TeamStats {
  TeamNumber team;
  List<Match> matches = [];
  int rankingPoints = 0;

  TeamStats(this.team);

  void calculateRankingPoints() {
    for (var m in matches) {
      TeamMatchStats tms = m.stats.firstWhere((element) => element.team == team);
      if (!tms.stats.dsqOrNoShow) {
        rankingPoints += tms.allianceColor == AllianceColor.blue ? m.blueAllianceRP : m.redAllianceRP;
      }
    }
  }
  
  int get numberOfMatches {
    return matches.length;
  }

  double get totalPoints {
    double total = 0;
    for (var m in matches) {
      var s = m.getStats(team)!;
      total += s.stats.totalPoints;
    }
    return total;
  }

  double get pointsPerMatch {
    return totalPoints / numberOfMatches;
  }

  double get autoPointsTotal {
    double total = 0;
    for (var m in matches) {
      var s = m.getStats(team)!;
      total += s.stats.autoPoints;
    }
    return total;
  }

  double get autoPointsPerMatch {
    return autoPointsTotal / numberOfMatches;
  }

  double get teleopPointsTotal {
    double total = 0;
    for (var m in matches) {
      var s = m.getStats(team)!;
      total += s.stats.teleopPoints;
    }
    return total;
  }

  double get teleopPointsPerMatch {
    return teleopPointsTotal / numberOfMatches;
  }

  double get teleopPointsWithoutRungPerMatch {
    return teleopPointsPerMatch - rungPointsPerMatch;
  }

  double get rungPointsTotal {
    double total = 0;
    for (var m in matches) {
      var s = m.getStats(team)!;
      total += s.stats.rungPoints;
    }
    return total;
  }

  double get rungPointsPerMatch {
    return rungPointsTotal / numberOfMatches;
  }

  factory TeamStats.fromJson(Map<String, dynamic> json) =>
    _$TeamStatsFromJson(json);
  Map<String, dynamic> toJson() => _$TeamStatsToJson(this);
}