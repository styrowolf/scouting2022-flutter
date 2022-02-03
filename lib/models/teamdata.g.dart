// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teamdata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamData _$TeamDataFromJson(Map<String, dynamic> json) => TeamData(
      json['team'] as int,
      (json['tournaments'] as List<dynamic>)
          .map((e) => Tournament.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TeamDataToJson(TeamData instance) => <String, dynamic>{
      'team': instance.team,
      'tournaments': instance.tournaments,
    };

TeamDataMetadata _$TeamDataMetadataFromJson(Map<String, dynamic> json) =>
    TeamDataMetadata(
      json['team'] as int,
      (json['tournaments'] as List<dynamic>)
          .map((e) => TournamentMetadata.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TeamDataMetadataToJson(TeamDataMetadata instance) =>
    <String, dynamic>{
      'team': instance.team,
      'tournaments': instance.tournaments,
    };
