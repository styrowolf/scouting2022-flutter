// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Leaderboard _$LeaderboardFromJson(Map<String, dynamic> json) => Leaderboard(
      Tournament.fromJson(json['tournament'] as Map<String, dynamic>),
    )..teamStats = (json['team_stats'] as List<dynamic>)
        .map((e) => TeamStats.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$LeaderboardToJson(Leaderboard instance) =>
    <String, dynamic>{
      'tournament': instance.tournament,
      'team_stats': instance.teamStats,
    };
