// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teammatchstats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamMatchStats _$TeamMatchStatsFromJson(Map<String, dynamic> json) =>
    TeamMatchStats(
      $enumDecode(_$AllianceColorEnumMap, json['alliance_color']),
      json['team'] as int,
      MatchStats.fromJson(json['stats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TeamMatchStatsToJson(TeamMatchStats instance) =>
    <String, dynamic>{
      'alliance_color': _$AllianceColorEnumMap[instance.allianceColor],
      'team': instance.team,
      'stats': instance.stats,
    };

const _$AllianceColorEnumMap = {
  AllianceColor.blue: 'blue',
  AllianceColor.red: 'red',
};
