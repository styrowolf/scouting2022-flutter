
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rapid_react_scouting/main.dart';
import 'package:rapid_react_scouting/models/match.dart';
import 'package:rapid_react_scouting/models/teammatchstats.dart';
import 'package:rapid_react_scouting/models/tournament.dart';
import 'package:rapid_react_scouting/screens/tournament/item.dart';

class MatchesList extends StatefulWidget {
  final List<Item<Match>> items;
  const MatchesList({Key? key, required this.items}): super(key: key);

  @override
  State<MatchesList> createState() => _MatchesListState();
}

class _MatchesListState extends State<MatchesList> {
  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return Text(
        'No matches scouted yet,\nno scouting = bad alliance (if any)',
        style: Theme.of(context).textTheme.headline6,
      );
    }
    return ExpansionPanelList(
      expansionCallback: (index, isExpanded) {
        setState(() {
          widget.items[index].isExpanded = !isExpanded;
        });
      },
      children: widget.items.map((item) {
        return ExpansionPanel(
          backgroundColor: Colors.grey[700],
          headerBuilder: (context, expanded) {
            return ListTile(
              title: Text(item.value.name),
            );
          },
          body: StatsColumn(stats: item.value.stats,),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

class StatsColumn extends StatelessWidget {
  final List<TeamMatchStats> stats;
  const StatsColumn({Key? key, required this.stats}): super (key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> l = [];
    if (stats.isEmpty) {
      l.add(const Text(
        'No stats for this match yet, mate!'
      ));
    } else {
      for (var stat in stats) {
        l.add(
          ListTile(
            title: Text(stat.team.toString()),
            onTap: () {
              // TODO: SCOUTING SCREENS OPENS WITH DATA INSIDE
              // look at: https://docs.flutter.dev/cookbook/navigation/navigation-basics
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Text("pushed it")));
            }
          )
        );
      }
    }
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: l,
        ),
      );
  }
}

class MatchesEditBox extends ConsumerStatefulWidget {
  final Function rebuilder;
  final Tournament t;
  const MatchesEditBox({Key? key, required this.rebuilder, required this.t}): super(key: key);
  @override
  ConsumerState<MatchesEditBox> createState() => _MatchesEditBoxState();
}

class _MatchesEditBoxState extends ConsumerState<MatchesEditBox> {
  final _matchNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  static const List<String> _presets = ['Practice', 'Qualification', 'Playoff', 'Custom'];
  int _selectedIndex = 0;

  String get selectedPreset {
    return _presets[_selectedIndex];
  }

  set selectedIndex(int i) {
    setState(() {
      _selectedIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    final client = ref.watch(rrsStateProvider.select((value) => value.client!));
    final notifier = ref.watch(rrsStateProvider.notifier);

    return Form(
      key: _formKey,
      child: Card(
        color: Colors.grey[700],
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: double.infinity,),
              Text(     
                'Got a match to scout?',  
                style: Theme.of(context).textTheme.headline6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Match type:'),
                  const SizedBox(width: 8,),
                  DropdownButton<String>(
                    value: selectedPreset,
                    items: List.from(_presets.map((p) => DropdownMenuItem(
                      value: p,
                      child: Text(p),
                    ))), 
                    onChanged: (String? s) {
                      _selectedIndex = _presets.indexOf(s!);
                    }
                  )
                ],
              ),
              const SizedBox(height: 16,),
              TextFormField(
                controller: _matchNameController,
                decoration: const InputDecoration(
                  labelText: 'Match name/number',
                  hintText: 'Write what\'s on FMS',
                ),
              ),
              const SizedBox(height: 16,),
              OutlinedButton(
                child: const Text('Add new match'),
                onPressed: () async {
                  String text = _matchNameController.text;
                  if (text != "") {
                    await client.createMatch(selectedPreset + ' - '+ text, widget.t.id);
                    await notifier.refresh();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Added ${selectedPreset + ' - '+ text} to ${widget.t.name}.'))
                    );
                    widget.rebuilder();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('A match with no name wouldn\' make much sense, would it?'))
                    );
                  }
                },
              ),
            ],
          ),
        ),
      )
    );
  }
}
