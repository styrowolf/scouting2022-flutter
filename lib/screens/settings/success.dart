import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rapid_react_scouting/main.dart';

class SuccessScreen extends ConsumerStatefulWidget {
  const SuccessScreen({Key? key}): super(key: key);

  @override
  ConsumerState<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends ConsumerState<SuccessScreen> {

  @override
  Widget build(BuildContext context) {
    final email = ref.watch(rrsStateProvider.select((value) => value.client!.user.email));
    final teams = ref.watch(rrsStateProvider.select((value) => value.client!.user.teams));
    final selectedIndex = ref.watch(rrsStateProvider.select((value) => value.client!.selectedTeamIndex));
    final notifier = ref.watch(rrsStateProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Settings', style: Theme.of(context).textTheme.headline1,),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: double.infinity,),
                  Text('Logged in', style: Theme.of(context).textTheme.headline2,),
                  const SizedBox(height: 8,),
                  Text('as $email', style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.right,),
                  const SizedBox(height: 4,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Selected team:'),
                      const SizedBox(width: 8,),
                      DropdownButton<int>(
                        value: teams[selectedIndex],
                        items: List.from(teams.map((team) => DropdownMenuItem(
                          value: team,
                          child: Text(team.toString()) 
                        ))), 
                        onChanged: (int? i) {
                          i = teams.indexOf(i!);
                          notifier.setSelectedTeam(i);
                        }
                      )
                    ],
                  ),
                  const SizedBox(height: 4,),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () async {
                        await notifier.logout();
                      },
                      child: const Text('Log out'),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}