import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rapid_react_scouting/main.dart';
import 'package:rapid_react_scouting/models/match.dart';
import 'package:rapid_react_scouting/models/teamdata.dart';
import 'package:rapid_react_scouting/models/tournament.dart';
import 'package:rapid_react_scouting/screens/tournament/item.dart';
import 'package:rapid_react_scouting/screens/tournament/tournamentlist.dart';

class TournamentScreen extends ConsumerStatefulWidget {
  const TournamentScreen({Key? key}): super(key: key);

  @override
  ConsumerState<TournamentScreen> createState() => _TournamentScreenState();
}

class _TournamentScreenState extends ConsumerState<TournamentScreen> {
  bool _easyRebuild = false;

  void rebuild() {
    setState(() {
      _easyRebuild = !_easyRebuild;
    });
  }

  @override
  Widget build(BuildContext context) {
    final client = ref.watch(rrsStateProvider.select((value) => value.client!));
    final Future<TeamData?> f = client.getData();
    
    return FutureBuilder(
      future: f,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data! as TeamData;
          final items = data.tournaments.map<Item<Tournament>>((e) => Item(e)).toList();
          return Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tournaments',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 16,),
                  TournamentsList(items: items, rebuilder: rebuild,),
                  const SizedBox(height: 16,),
                  TournamentsEditBox(rebuilder: rebuild,),
                  const SizedBox(height: 16,)
                ],
              )
            )
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
