import 'package:rapid_react_scouting/models/identifiable.dart';
import 'package:rapid_react_scouting/models/match.dart';

import 'package:json_annotation/json_annotation.dart';

part 'tournament.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Tournament extends Identifiable {
  String name;
  @override
  final String prefix = 'tournament-';
  @override
  late String id;
  List<Match> matches = [];

  Tournament(this.name) {
    assignId();
  }

  @override
  void assignId() {
    id = generateId(name);
  }

  Tournament.justId(this.name) {
    id = name;
  }

  TournamentMetadata toMetadata() {
    var metadata = TournamentMetadata(name);
    metadata.matches = List.from(matches.map((e) => e.toMetadata()));
    return metadata;
  }

  void putMatch(Match m) {
    var i = matches.indexOf(m);
    if (i == -1) {
      matches.add(m);
    } else {
      matches[i] = m;
    }
  }

  Match? getMatch(String id) {
    var list = List.from(matches.where((element) => element.id == id));
    if (list.length != 1) {
      return null;
    }
    return list[0];
  }

  factory Tournament.fromJson(Map<String, dynamic> json) =>
    _$TournamentFromJson(json);
  Map<String, dynamic> toJson() => _$TournamentToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TournamentMetadata extends Identifiable {
  String name;
  @override
  final String prefix = 'tournament-';
  @override
  late final String id;
  List<MatchMetadata> matches = [];

  TournamentMetadata(this.name) {
    assignId();
  }

  @override
  void assignId() {
    id = generateId(name);
  }

  TournamentMetadata.justId(this.name) {
    id = name;
  }

  factory TournamentMetadata.fromJson(Map<String, dynamic> json) =>
    _$TournamentMetadataFromJson(json);
  Map<String, dynamic> toJson() => _$TournamentMetadataToJson(this);
}