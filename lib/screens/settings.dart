import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rapid_react_scouting/screens/settings/invalidcredentials.dart';
import 'package:rapid_react_scouting/screens/settings/loginregister.dart';
import 'package:rapid_react_scouting/screens/settings/success.dart';
import 'package:rapid_react_scouting/screens/settings/teamless.dart';
import 'package:rapid_react_scouting/state.dart';
import 'package:rapid_react_scouting/main.dart';

class Settings extends ConsumerWidget {
  const Settings({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Status status = ref.watch(rrsStateProvider.select((value) => value.status));
    switch (status) {
      case Status.successfullyLoggedIn:
        return const SuccessScreen();
      case Status.invalidCredentials:
        return const InvalidCredentialsScreen();
      case Status.noCredentials:
        return const LoginRegisterScreen();
      case Status.noTeams:
        return const Teamless();
    }
  }
}