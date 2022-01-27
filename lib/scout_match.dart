import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MatchScoutingScreen extends StatelessWidget {
  const MatchScoutingScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Team number',
              labelStyle: Theme.of(context).textTheme.bodyText1,
              ),
            onChanged: (number) => print(number),
          )
        ],
      )
    );
  }
}