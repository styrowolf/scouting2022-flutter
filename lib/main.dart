import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rapid_react_scouting/screens/settings.dart';
import 'package:rapid_react_scouting/screens/tournament.dart';
import 'package:rapid_react_scouting/state.dart';
import 'theme.dart';
import 'screens/scouting.dart';

final rrsStateProvider = StateNotifierProvider<RRSStateNotifier, RRSState>((ref) {
  return RRSStateNotifier();
});

void main() {
  runApp(ProviderScope(child: RRSApp()));
}

class RRSApp extends StatelessWidget {
  RRSApp({Key? key}) : super(key: key);
  final theme = AppTheme.dark();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rapid React Scouting',
      theme: theme,
      home: const RRSHome(title: 'Rapid React Scouting'),
    );
  }
}

class RRSHome extends ConsumerStatefulWidget {
  const RRSHome({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  ConsumerState<RRSHome> createState() => _RRSHomeState();
}

class _RRSHomeState extends ConsumerState<RRSHome> {
  late Future<void> f;
  int _selectedIndex = 3;

  @override
  void initState() {
    super.initState();
    f = ref.read(rrsStateProvider).initialize();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = ref.watch(rrsStateProvider.select((value) => value.isDisabled)) ? 3 : index;
    });
  }

  Widget getChild() {
    switch (_selectedIndex) {
      case 0:
        return TournamentScreen(key: UniqueKey());
      case 1:
        return Scouting(key: UniqueKey());
      case 2:
        return const Text("Leaderboard");
      case 3:
        return Settings(key: UniqueKey());
      default:
        return const Text('this cannot happen, so?');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: f,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator(),);
        } else {
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_tree,
                    size: 24,
                  ),
                  label: "Tournaments",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add,
                    size: 24,
                  ),
                  label: "Scouting",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.leaderboard,
                    size: 24,
                  ),
                  label: "Leaderboard",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    size: 24,
                  ),
                  label: "Settings",
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: getChild(),
          );
        }
      }
    );
  }
}
