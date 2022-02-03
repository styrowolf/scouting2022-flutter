import 'package:rapid_react_scouting/models/teamnumber.dart';
import 'package:rapid_react_scouting/models/tournament.dart';

import 'package:json_annotation/json_annotation.dart';

part 'teamdata.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TeamData {
  TeamNumber team;
  List<Tournament> tournaments;

  TeamData(this.team, this.tournaments);

  TeamDataMetadata toMetadata() {
    var list = List<TournamentMetadata>.from(tournaments.map((e) => e.toMetadata()));
    var metadata = TeamDataMetadata(team, list);
    return metadata;
  }

  void putTournament(Tournament t) {
    var i = tournaments.indexOf(t);
    if (i == -1) {
      tournaments.add(t);
    } else {
      tournaments[i] = t;
    }
  }

  Tournament? getTournament(String id) {
    var list = List.from(tournaments.where((element) => element.id == id));
    if (list.length != 1) {
      return null;
    }
    return list[0];
  }

  factory TeamData.fromJson(Map<String, dynamic> json) =>
    _$TeamDataFromJson(json);
  Map<String, dynamic> toJson() => _$TeamDataToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TeamDataMetadata {
  TeamNumber team;
  List<TournamentMetadata> tournaments;

  TeamDataMetadata(this.team, this.tournaments);

  factory TeamDataMetadata.fromJson(Map<String, dynamic> json) =>
    _$TeamDataMetadataFromJson(json);
  Map<String, dynamic> toJson() => _$TeamDataMetadataToJson(this);
}