import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rapid_react_scouting/main.dart';
import 'package:rapid_react_scouting/models/tournament.dart';
import 'package:rapid_react_scouting/screens/tournament/item.dart';
import 'package:rapid_react_scouting/screens/tournament/matchlist.dart';

class TournamentsList extends StatefulWidget {
  final List<Item<Tournament>> items;
  final Function rebuilder;
  const TournamentsList({Key? key, required this.items, required this.rebuilder}): super(key: key);

  @override
  State<TournamentsList> createState() => _TournamentsListState();
}

class _TournamentsListState extends State<TournamentsList> {
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (index, isExpanded) {
        setState(() {
          widget.items[index].isExpanded = !isExpanded;
        });
      },
      children: widget.items.map((item) {
        return ExpansionPanel(
          headerBuilder: (context, expanded) {
            return ListTile(
              title: Text(item.value.name, style: Theme.of(context).textTheme.headline2),
            );
          },
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MatchesList(items: item.value.matches.map((e) => Item(e)).toList()),
                const SizedBox(height: 16,),
                MatchesEditBox(rebuilder: widget.rebuilder, t: item.value)
              ],
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

class TournamentsEditBox extends ConsumerStatefulWidget {
  final Function rebuilder;
  const TournamentsEditBox({Key? key, required this.rebuilder}): super(key: key);
  @override
  ConsumerState<TournamentsEditBox> createState() => _TournamentsEditBoxState();
}

class _TournamentsEditBoxState extends ConsumerState<TournamentsEditBox> {
  final _tournamentNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final client = ref.watch(rrsStateProvider.select((value) => value.client!));
    final notifier = ref.watch(rrsStateProvider.notifier);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: double.infinity,),
            Text(     
              'Participating in another tournament?',  
              style: Theme.of(context).textTheme.headline2,
            ),
            TextField(
                controller: _tournamentNameController,
                decoration: const InputDecoration(
                  labelText: 'Tournament name',
                ),
              ),
            const SizedBox(height: 16,),
            OutlinedButton(
              child: const Text('Add new tournament'),
              onPressed: () async {       
                String text = _tournamentNameController.text;
                if (text != "") {
                  await client.createTournament(text);
                  await notifier.refresh();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Added $text.'))
                  );
                  widget.rebuilder();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('A tournament with no name wouldn\'t make much sense, would it?'))
                  );
                }
                
              },
            ),
          ]
        ),
      )
    );
  }
}