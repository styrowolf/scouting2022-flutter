// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Match _$MatchFromJson(Map<String, dynamic> json) => Match(
      json['name'] as String,
    )
      ..id = json['id'] as String
      ..stats = (json['stats'] as List<dynamic>)
          .map((e) => TeamMatchStats.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$MatchToJson(Match instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'stats': instance.stats,
    };

MatchMetadata _$MatchMetadataFromJson(Map<String, dynamic> json) =>
    MatchMetadata(
      json['name'] as String,
    )..id = json['id'] as String;

Map<String, dynamic> _$MatchMetadataToJson(MatchMetadata instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
    };
