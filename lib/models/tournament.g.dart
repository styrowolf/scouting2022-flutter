// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tournament _$TournamentFromJson(Map<String, dynamic> json) => Tournament(
      json['name'] as String,
    )
      ..id = json['id'] as String
      ..matches = (json['matches'] as List<dynamic>)
          .map((e) => Match.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$TournamentToJson(Tournament instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'matches': instance.matches,
    };

TournamentMetadata _$TournamentMetadataFromJson(Map<String, dynamic> json) =>
    TournamentMetadata(
      json['name'] as String,
    )
      ..id = json['id'] as String
      ..matches = (json['matches'] as List<dynamic>)
          .map((e) => MatchMetadata.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$TournamentMetadataToJson(TournamentMetadata instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'matches': instance.matches,
    };
