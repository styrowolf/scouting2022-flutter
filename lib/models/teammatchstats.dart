import 'package:rapid_react_scouting/models/matchstats.dart';
import 'package:rapid_react_scouting/models/teamnumber.dart';

import 'package:json_annotation/json_annotation.dart';

part 'teammatchstats.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TeamMatchStats {
  AllianceColor allianceColor;
  TeamNumber team;
  MatchStats stats;

  TeamMatchStats(this.allianceColor, this.team, this.stats);

  @override
  bool operator ==(Object other) => other is TeamMatchStats && team == other.team;

  @override
  int get hashCode => team.hashCode;

  factory TeamMatchStats.fromJson(Map<String, dynamic> json) =>
      _$TeamMatchStatsFromJson(json);
  Map<String, dynamic> toJson() => _$TeamMatchStatsToJson(this);
}

enum AllianceColor {
  blue,
  red,
}