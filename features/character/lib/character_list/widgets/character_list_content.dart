import 'package:character_details/character_details.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';

import '../bloc/character_list_bloc.dart';
import 'character_list_tile.dart';

class CharacterListContent extends StatelessWidget {
  const CharacterListContent({
    required this.data,
    required this.hasReachedMax,
  });

  final List<Character> data;
  final bool hasReachedMax;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InfiniteList(
        itemBuilder: (context, index) => CharacterListTile(
          data[index],
          key: ValueKey(data[index].id),
          onPressed: () => context.pushRoute(
            CharacterDetailsRoute(id: data[index].id),
          ),
        ),
        itemsCount: data.length,
        loadMore: () => context.read<CharacterListBloc>().add(
              CharacterListEvent.fetch(),
            ),
        hasReachedMax: hasReachedMax,
      ),
    );
  }
}
