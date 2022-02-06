import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rapid_react_scouting/main.dart';
import 'package:rapid_react_scouting/models/teamdata.dart';
import 'package:rapid_react_scouting/models/tournament.dart';

class TournamentScreen extends ConsumerStatefulWidget {
  const TournamentScreen({Key? key}): super(key: key);

  @override
  ConsumerState<TournamentScreen> createState() => _TournamentScreenState();
}

class _TournamentScreenState extends ConsumerState<TournamentScreen> {
  bool _easyRefresh = false;

  void refresh() {
    setState(() {
      _easyRefresh = !_easyRefresh;
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
          final items = data.tournaments.map<Item>((e) => Item(e)).toList();
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
                  TournamentsList(items: items),
                  const SizedBox(height: 16,),
                  TournamentsEditBox(refresher: refresh),
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

class Item {
  Tournament tournament;
  bool isExpanded = false;
  Item(this.tournament);
}

class TournamentsList extends StatefulWidget {
  final List<Item> items;
  const TournamentsList({Key? key, required this.items}): super(key: key);

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
              title: Text(item.tournament.name),
            );
          },
          body: const Card(
            child: Text('open'),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

class TournamentsEditBox extends ConsumerStatefulWidget {
  final Function refresher;
  const TournamentsEditBox({Key? key, required this.refresher}): super(key: key);
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
                  widget.refresher();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('A tournament with no name wouldn\' make much sense, would it?'))
                  );
                }
              },
            ),
          ]
        ),
      ),
    );
  }
}