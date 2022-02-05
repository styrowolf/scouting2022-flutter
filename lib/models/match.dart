import 'package:rapid_react_scouting/models/identifiable.dart';
import 'package:rapid_react_scouting/models/teammatchstats.dart';
import 'package:rapid_react_scouting/models/teamnumber.dart';

import 'package:json_annotation/json_annotation.dart';

part 'match.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Match extends Identifiable {
  String name;
  @override
  final String prefix = 'match-';
  @override
  late final String id;
  List<TeamMatchStats> stats = [];

  Match(this.name) {
    assignId();
  }

  List<TeamNumber> get teams {
    return List.from(stats.map((e) => e.team));
  }

  List<TeamMatchStats> get redAlliance {
    return List.from(stats.where((element) => element.allianceColor == AllianceColor.red));
  }

  List<TeamMatchStats> get blueAlliance {
    return List.from(stats.where((element) => element.allianceColor == AllianceColor.blue));
  }

  int get redAllianceRP {
    return _allianceRP(redAlliance);
  }

  int get blueAllianceRP {
    return _allianceRP(blueAlliance);
  }

  int _allianceRP(List<TeamMatchStats> a) {
    int rp = 0;
    
    // cargo
    int totalCargoScored = 0;
    int autoCargoScored = 0;

    // hangar
    int hangarPoints = 0;
    
    for (var t in a) {
      totalCargoScored += t.stats.cargoScored;
      autoCargoScored += t.stats.autoCargoScored;
      hangarPoints += t.stats.rungPoints;
    }

    int cargoThreshold = autoCargoScored >= 5 ? 18 : 20;
    
    if (totalCargoScored > cargoThreshold) {
      rp += 1;
    }

    const int hangarThreshold = 16;
    if (hangarPoints >= hangarThreshold) {
      rp += 1;
    }
    try {
      rp += a.first.stats.resultRankingPoints;
    } catch (e) { rp += 0; }

    return rp;
  }

  @override
  void assignId() {
    id = generateId(name);
  }

  Match.justId(this.name) {
    id = name;
  }

  MatchMetadata toMetadata() {
    return MatchMetadata(name);
  }

  void putStats(TeamMatchStats tms) {
    var i = stats.indexOf(tms);
    if (i == -1) {
      stats.add(tms);
    } else {
      stats[i] = tms;
    }
  }

  TeamMatchStats? getStats(TeamNumber team) {
    var list = List.from(stats.where((element) => element.team == team));
    if (list.length != 1) {
      return null;
    }
    return list[0];
  }

  factory Match.fromJson(Map<String, dynamic> json) =>
    _$MatchFromJson(json);
  Map<String, dynamic> toJson() => _$MatchToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MatchMetadata extends Identifiable {
  String name;
  @override
  final String prefix = 'match-';
  @override
  late final String id;

  MatchMetadata(this.name) {
    assignId();
  }

  @override
  void assignId() {
    id = generateId(name);
  }

  MatchMetadata.justId(this.name) {
    id = name;
  }

  factory MatchMetadata.fromJson(Map<String, dynamic> json) =>
    _$MatchMetadataFromJson(json);
  Map<String, dynamic> toJson() => _$MatchMetadataToJson(this);
}