import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppIconButton(
          onPressed: context.maybePop,
          child: const Icon(Icons.arrow_back),
        ),
        title: const Text('Title'),
      ),
      body: Container(),
    );
  }
}
