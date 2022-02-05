import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    Status status = ref.watch(rrsStateProvider.select((value) => value.status));
    switch (status) {
      case Status.successfullyLoggedIn:
        return const Text("logged in succesfully");
      case Status.invalidCredentials:
        return const Text("invalid creds");
      case Status.noCredentials:
        return const Text("login or register");
      case Status.noTeams:
        return const Text("get some teams");
    }
  }
}