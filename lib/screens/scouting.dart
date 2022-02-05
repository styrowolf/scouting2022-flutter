import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Scouting extends StatefulWidget {
  const Scouting({Key? key}): super(key: key);

  @override
  State<Scouting> createState() => _ScoutingState();
}

class _ScoutingState extends State<Scouting> {
  int _teamNumber = 0;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final String text = _controller.text;
      try {
        _teamNumber = int.parse(text);
        _controller.value = _controller.value.copyWith(
          text: text.trim(),
        );
      } catch(e) {
        _controller.value = _controller.value.copyWith(
          text: text == "" ||  _teamNumber == 0 ? "" : _teamNumber.toString(),
          selection: TextSelection(
            baseOffset: _controller.value.selection.baseOffset == 0 ? _controller.value.selection.baseOffset : _controller.value.selection.baseOffset - 1, 
            extentOffset: _controller.value.selection.extentOffset == 0 ? _controller.value.selection.extentOffset : _controller.value.selection.extentOffset -1,
          )
        );
      }
    });
  }

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
            decoration: const InputDecoration(
              labelText: 'Team number',
            ),
            controller: _controller,
          )
        ],
      )
    );
  }
}