import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rapid_react_scouting/client.dart';
import 'package:rapid_react_scouting/credentials.dart';

// https://riverpod.dev/docs/providers/state_notifier_provider

class RRSState {
  RRSClient? client;
  Credentials? _credentials;
  late Status status;

  static Future<RRSState> get(Credentials? credentials) async {
    RRSState state = RRSState();
    if (credentials != null) {
      state.credentials = credentials;
    } else {
      credentials = await Credentials.fromStorage();
      if (credentials != null) {
        state.credentials = credentials;
      }
    }
    return state;
  }

  void _setupClientAndSetStatus() {
    if (_credentials == null) {
      status = Status.noCredentials;
    } else {
      try {
        client = RRSClient.init(_credentials!);
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

  set credentials(Credentials credentials) {
    _credentials = credentials;
    _setupClientAndSetStatus();
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
  RRSStateNotifier() {
    super(RRSState());
  }


}