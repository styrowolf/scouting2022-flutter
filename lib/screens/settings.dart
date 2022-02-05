import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rapid_react_scouting/screens/settings/invalidcredentials.dart';
import 'package:rapid_react_scouting/screens/settings/loginregister.dart';
import 'package:rapid_react_scouting/state.dart';
import 'package:rapid_react_scouting/main.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({Key? key}): super(key: key);

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Status status = ref.watch(rrsStateProvider.select((value) => value.status));
    switch (status) {
      case Status.successfullyLoggedIn:
        return const Text("logged in succesfully");
      case Status.invalidCredentials:
        return const InvalidCredentialsScreen();
      case Status.noCredentials:
        return const LoginRegisterScreen();
      case Status.noTeams:
        return const Text("get some teams");
    }
  }
}