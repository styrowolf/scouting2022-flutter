import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'teamstats.dart';
import 'package:hex/hex.dart';

class Tournament {
  String name;
  String _id = 'tournament';
  List<Match> matches = <Match>[];

  Tournament(this.name) {
    _id += '-' + const HexEncoder().convert(name.hashCode as List<int>);
  }

  Tournament.justId(this.name) {
    _id = name;
  }

  @override
  bool operator ==(Object other) => hashCode == other.hashCode;

  @override
  int get hashCode => _id.hashCode;
}

typedef TeamNumber = int;

class Match {
  String name;
  String _id = 'match';
  Map<TeamNumber, TeamMatchStats> blueAlliance = {};
  Map<TeamNumber, TeamMatchStats> redAlliance = {};

  Match(this.name) {
    _id = '-' + const HexEncoder().convert(name.hashCode as List<int>);
  }

  Match.justId(this.name) {
    _id = name;
  }

  @override
  bool operator ==(Object other) => hashCode == other.hashCode;

  @override
  int get hashCode => _id.hashCode;
}