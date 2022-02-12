import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rapid_react_scouting/main.dart';
import 'package:rapid_react_scouting/models/match.dart';
import 'package:rapid_react_scouting/models/teamdata.dart';
import 'package:rapid_react_scouting/models/tournament.dart';

class Scouting extends ConsumerStatefulWidget {
  const Scouting({Key? key}): super(key: key);

  @override
  ConsumerState<Scouting> createState() => _ScoutingState();
}

class _ScoutingState extends ConsumerState<Scouting> {
  int _selectedTournamentIndex = 0;
  int _selectedMatchIndex = 0;
  final _controller = TextEditingController();

  void setSelectedTournamentIndex(int i) {
    if (i != _selectedTournamentIndex) {
      setState(() {
        _selectedMatchIndex = 0;
        _selectedTournamentIndex = i;
      });
    }
  }
  
  void setSelectedMatchIndex(int i) {
    setState(() {
      _selectedMatchIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    final client = ref.watch(rrsStateProvider.select((value) => value.client!));
    final Future<TeamData?> f = client.getData();
    
    return FutureBuilder(
      future: f,
      builder: (context, snapshot) {
        final TeamData data;
        if (snapshot.hasData) {
          data = snapshot.data! as TeamData;
        } else {
          return const Center(child: CircularProgressIndicator());
        }
          return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Tournament:'),
                    const SizedBox(width: 8,),
                    DropdownButton<Tournament>(
                      value: data.tournaments[_selectedTournamentIndex],
                      items: List.from(data.tournaments.map((t) => DropdownMenuItem(
                        value: t,
                        child: Text(t.name)) 
                      )), 
                      onChanged: (Tournament? t) {
                        int index = data.tournaments.indexOf(t!);
                        setSelectedTournamentIndex(index);
                      }
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Match:'),
                    const SizedBox(width: 8,),
                    DropdownButton<Match>(
                      value: data.tournaments[_selectedTournamentIndex].matches[_selectedMatchIndex],
                      items: List.from(data.tournaments[_selectedTournamentIndex].matches.map((m) => DropdownMenuItem(
                        value: m,
                        child: Text(m.name)) 
                      )), 
                      onChanged: (Match? m) {
                        int index = data.tournaments[_selectedTournamentIndex].matches.indexOf(m!);
                        setSelectedMatchIndex(index);
                      }
                    ),
                  ],
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Team number')
                  ),
                  controller: _controller,
                ),
              ],
            )
          )
        );
      },
    );
  }
}

