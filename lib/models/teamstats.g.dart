// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teamstats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamStats _$TeamStatsFromJson(Map<String, dynamic> json) => TeamStats(
      json['team'] as int,
    )
      ..matches = (json['matches'] as List<dynamic>)
          .map((e) => Match.fromJson(e as Map<String, dynamic>))
          .toList()
      ..rankingPoints = json['ranking_points'] as int;

Map<String, dynamic> _$TeamStatsToJson(TeamStats instance) => <String, dynamic>{
      'team': instance.team,
      'matches': instance.matches,
      'ranking_points': instance.rankingPoints,
    };
