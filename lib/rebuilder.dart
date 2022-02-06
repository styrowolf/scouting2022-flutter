import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rapid_react_scouting/screens/scouting.dart';

class Rebuilder {
  final List<bool> rebuilderState;

  Rebuilder({this.rebuilderState = const [false, false, false, false]});
}

class RebuilderNotifier extends StateNotifier<Rebuilder> {
  RebuilderNotifier(): super(Rebuilder());

  bool get tournaments {
    return state.rebuilderState[0];
  }

  bool get scouting {
    return state.rebuilderState[1];
  }

  bool get leaderboard {
    return state.rebuilderState[2];
  }

  bool get settings {
    return state.rebuilderState[3];
  }

  void rebuildTournaments() {
    _rebuild(0);
  }

  void rebuildScouting() {
    _rebuild(1);
  }

  void rebuildLeaderboard() {
    _rebuild(2);
  }

  void rebuildSettings() {
    _rebuild(3);
  }

  void rebuildAll() {
    for (var i = 0; i < state.rebuilderState.length; i++) {
      _rebuild(i);
    }
  }

  void _rebuild(int index) {
    List<bool> _state = List.generate(4, (index) => false);
    for (var i = 0; i < _state.length; i++) {
      _state[i] = _state[i] || state.rebuilderState[i];
    }
    _state[index] = !_state[index];
    state = Rebuilder(rebuilderState: _state);
  }
}