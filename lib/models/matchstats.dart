import 'package:json_annotation/json_annotation.dart';

part 'matchstats.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MatchStats {
  // Auto
  bool taxi = false;
  int autoLowerHub = 0;
  int autoHigherHub = 0;

  // Teleop
  int teleopLowerHub = 0;
  int teleopHigherHub = 0;
  Rung bar = Rung.none;

  bool dsqOrNoShow = false;
  Result result = Result.draw;

  MatchStats();

  // Auto
  void toggleTaxi() {
    taxi = !taxi;
  }
  
  void incrementAutoLowerHub() { 
    autoLowerHub++;
  }

  void decrementAutoLowerHub() {
    autoLowerHub--;
  }

  void incrementAutoHigherHub() {
    autoHigherHub++;
  }

  void decrementAutoHigherHub() {
    autoHigherHub--;
  }

  // Teleop
  void incrementTeleopLowerHub() { 
    teleopLowerHub++;
  }

  void decrementTeleopLowerHub() {
    teleopLowerHub--;
  }

  void incrementTeleopHigherHub() {
    teleopHigherHub++;
  }

  void decrementTeleopHigherHub() {
    teleopHigherHub--;
  }

  void toggleDsqOrNoShow() {
    dsqOrNoShow = !dsqOrNoShow;
  }

  set rung(Rung rung) {
    bar = rung;
  }

  // Number of cargo scored
  int get cargoScored {
    return autoCargoScored + teleopCargoScored;
  }

  int get autoCargoScored {
    return autoLowerHub + autoLowerHub;
  }

  int get teleopCargoScored {
    return teleopLowerHub + teleopHigherHub;
  }

  // Points
  int get taxiPoints {
    return 2 * (taxi as int);
  }

  int get autoLowerHubPoints {
    return 2 * autoLowerHub;
  }

  int get autoHigherHubPoints {
    return 4 * autoHigherHub;
  }

  int get autoPoints {
    return autoLowerHubPoints + autoHigherHubPoints + taxiPoints;
  }

  int get teleopLowerHubPoints {
    return 1 * teleopLowerHub;
  }

  int get teleopHigherHubPoints {
    return 2 * teleopHigherHub;
  }

  int get rungPoints {
    return rungToPoints(bar);
  }

  int get teleopPoints {
    return teleopLowerHubPoints + teleopHigherHubPoints + rungPoints;
  }

  int get totalPoints {
    return autoPoints + teleopPoints;
  }

  // Result
  int get resultRankingPoints {
    return resultToRankingPoints(result);
  }

  // Serialization
  factory MatchStats.fromJson(Map<String, dynamic> json) =>
    _$MatchStatsFromJson(json);
  Map<String, dynamic> toJson() => _$MatchStatsToJson(this);
}

enum Result {
  lost,
  draw,
  won,
}

int resultToRankingPoints(Result result) {
  switch (result) {
    case Result.lost:
      return 0;
    case Result.draw:
      return 1;
    case Result.won:
      return 2;
  }
}

enum Rung {
  none,
  low,
  middle,
  high,
  traversal,
}

int rungToPoints(Rung rung) {
  switch (rung) {
    case Rung.none:
      return 0;
    case Rung.low:
      return 4;
    case Rung.middle:
      return 6;
    case Rung.high:
      return 10;
    case Rung.traversal:
      return 15;
  }
}

// real-time sync