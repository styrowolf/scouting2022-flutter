class TeamMatchStats {
  // Auto
  bool taxi = false;
  int autoLowerHub = 0;
  int autoHigherHub = 0;

  // Teleop
  int teleopLowerHub = 0;
  int teleopHigherHub = 0;
  Rung bar = Rung.none;

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

  set rung(Rung rung) {
    bar = rung;
  }

  // Points
  int get autoPoints {
    return 2 * autoLowerHub + 4 * autoHigherHub + 2 * (taxi as int);
  }

  int get teleopPoints {
    return 1 * teleopLowerHub + 2 * teleopHigherHub + toPoints(bar);
  }

  int get totalPoints {
    return autoPoints + teleopPoints;
  }
}

enum Rung {
  none,
  low,
  middle,
  high,
  traversal,
}

int toPoints(Rung rung) {
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