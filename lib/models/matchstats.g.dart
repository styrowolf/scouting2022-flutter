// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matchstats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchStats _$MatchStatsFromJson(Map<String, dynamic> json) => MatchStats()
  ..taxi = json['taxi'] as bool
  ..autoLowerHub = json['auto_lower_hub'] as int
  ..autoHigherHub = json['auto_higher_hub'] as int
  ..teleopLowerHub = json['teleop_lower_hub'] as int
  ..teleopHigherHub = json['teleop_higher_hub'] as int
  ..bar = $enumDecode(_$RungEnumMap, json['bar'])
  ..dsqOrNoShow = json['dsq_or_no_show'] as bool
  ..result = $enumDecode(_$ResultEnumMap, json['result']);

Map<String, dynamic> _$MatchStatsToJson(MatchStats instance) =>
    <String, dynamic>{
      'taxi': instance.taxi,
      'auto_lower_hub': instance.autoLowerHub,
      'auto_higher_hub': instance.autoHigherHub,
      'teleop_lower_hub': instance.teleopLowerHub,
      'teleop_higher_hub': instance.teleopHigherHub,
      'bar': _$RungEnumMap[instance.bar],
      'dsq_or_no_show': instance.dsqOrNoShow,
      'result': _$ResultEnumMap[instance.result],
    };

const _$RungEnumMap = {
  Rung.none: 'none',
  Rung.low: 'low',
  Rung.middle: 'middle',
  Rung.high: 'high',
  Rung.traversal: 'traversal',
};

const _$ResultEnumMap = {
  Result.lost: 'lost',
  Result.draw: 'draw',
  Result.won: 'won',
};
