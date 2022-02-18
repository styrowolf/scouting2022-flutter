import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rapid_react_scouting/client.dart';
import 'package:rapid_react_scouting/credentials.dart';
import 'package:http/http.dart' as http;

// https://riverpod.dev/docs/providers/state_notifier_provider

class RRSState {
  RRSClient? client;
  late Credentials? _credentials;
  late Status status;

  RRSState();
  RRSState._construct(this.client, this._credentials, this.status);

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
    await _setupClientAndSetStatus();
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
    await state._setupClientAndSetStatus();
    return state;
  }

  Future<void> _setupClientAndSetStatus() async {
    if (_credentials == null) {
      status = Status.noCredentials;
    } else {
      try {
        client = await RRSClient.init(_credentials!);
        if (client!.hasTeams) {
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
    return RRSState._construct(client, _credentials, status);
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

  Future<void> refresh() async {
    RRSState _state = state.copyWith();
    await _state.client!.refreshToken();
    state = _state;
  }

  Future<void> logout() async {
    RRSState _state = state.copyWith();
    _state._credentials = null;
    await _state._setupClientAndSetStatus();
    state = _state;
  }

  Future<void> login({Credentials? credentials, String? email, String? password}) async {
    if (email != null && password != null) {
      credentials ??= Credentials(email, password);
    }
    if (credentials == null) return;
    RRSState _state = state.copyWith();
    _state._credentials = credentials;
    await _state._setupClientAndSetStatus();
    await credentials.toStorage();
    state = _state;
  }

  Future<void> register({Credentials? credentials, String? email, String? password}) async {
    if (email != null && password != null) {
      credentials ??= Credentials(email, password);
    }
    if (credentials == null) return;
    await http.Client().post(RRSClient.registrationEndpoint, 
    body: jsonEncode({"email": credentials.email, "password": credentials.password}),
    headers: {"Content-Type": "application/json; charset=utf-8"});
    await login(credentials: credentials);
  }

  void setSelectedTeam(int index) {
    RRSState _state = state.copyWith();
    _state.client!.selectedTeamIndex = index;
    state = _state;
  }
}