import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rapid_react_scouting/client.dart';
import 'package:rapid_react_scouting/credentials.dart';

// https://riverpod.dev/docs/providers/state_notifier_provider

class RRSState {
  late final RRSClient client;
  late final Credentials? _credentials;
  late final Status status;

  Future<void> initialize({Credentials? credentials}) async {
    if (credentials != null) {
      _credentials = credentials;
    } else {
      credentials = await Credentials.fromStorage();
      if (credentials != null) {
        _credentials = credentials;
      }
      _credentials = null;
    }
    _setupClientAndSetStatus();
  }

  static Future<RRSState> get(Credentials? credentials) async {
    RRSState state = RRSState();
    if (credentials != null) {
      state._credentials = credentials;
    } else {
      credentials = await Credentials.fromStorage();
      if (credentials != null) {
        state._credentials = credentials;
      }
    }
    state._setupClientAndSetStatus();
    return state;
  }

  void _setupClientAndSetStatus() {
    if (_credentials == null) {
      status = Status.noCredentials;
    } else {
      try {
        client = RRSClient.init(_credentials!);
        if (client.hasTeams) {
          status = Status.successfullyLoggedIn;
        } else {
          status = Status.noTeams;
        }
      } catch (e) {
        status = Status.invalidCredentials;
      }
    }
  }

  RRSState copyWith() {
    return this;
  }

  bool get noCredentials {
    return status == Status.noCredentials;
  }

  bool get invalidCredentials {
    return status == Status.invalidCredentials;
  }

  bool get noTeams {
    return status == Status.noTeams;
  }

  bool get successfullyLoggedIn {
    return status == Status.successfullyLoggedIn;
  }

  bool get isDisabled {
    return noCredentials || invalidCredentials || noTeams;
  }
}

enum Status {
  noCredentials,
  invalidCredentials,
  noTeams,
  successfullyLoggedIn,
}

class RRSStateNotifier extends StateNotifier<RRSState> {
  RRSStateNotifier(): super(RRSState());

  Future<void> initialize({Credentials? credentials}) async {
    RRSState _state = state.copyWith();
    await _state.initialize(credentials: credentials);
    state = _state;
  }

  void logout() {
    RRSState _state = state.copyWith();
    _state._credentials = null;
    _state._setupClientAndSetStatus();
    _state = state;
  }

  void login({Credentials? credentials, String? email, String? password}) {
    if (email != null && password != null) {
      credentials ??= Credentials(email, password);
    }
    if (credentials == null) return;
    RRSState _state = state.copyWith();
    _state._credentials = credentials;
    _state._setupClientAndSetStatus();
    credentials.toStorage();
    _state = state;
  }
}