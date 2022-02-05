import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rapid_react_scouting/main.dart';

class InvalidCredentialsScreen extends ConsumerWidget {
  const InvalidCredentialsScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(rrsStateProvider.notifier);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Invalid Credentials', style: Theme.of(context).textTheme.headline1,),
          const SizedBox(height: 16),
          const Text('''The credentials you have entered are invalid, meaning either that '''
            '''the email and the password do not match or that there is no account with that email.'''),
          const SizedBox(height: 16),
          const Text('''Please try registering or logging in again.'''),
          const SizedBox(height: 16),
          OutlinedButton(
            child: const Text("Login or register"),
            onPressed: notifier.logout,
          )
        ],
      )
    );
  }
}