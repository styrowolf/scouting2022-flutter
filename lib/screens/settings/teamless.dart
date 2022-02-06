import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rapid_react_scouting/main.dart';

class Teamless extends ConsumerWidget {
  const Teamless({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(rrsStateProvider.notifier);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('You\'re teamless :(', style: Theme.of(context).textTheme.headline1,),
          const SizedBox(height: 16),
          const Text('''This app is basically useless when you do not have a team. '''
            '''Please have your team captain/advisor mail kurogu.24@robcol.k12.tr with your email for me to '''
            '''attach that team number to your account.'''
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () async {
                await notifier.refresh();
              },
              child: const Text('Refresh'),
            ),
          ),
          const SizedBox(height: 8),
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
      )
    );
  }
}