import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../character.dart';
import '../bloc/character_list_bloc.dart';
import 'character_list_tile.dart';

@RoutePage()
class CharacterListScreen extends StatelessWidget {
  const CharacterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CharacterListBloc(appLocator.get<GetCharacterListUseCase>())
            ..add(CharacterListEvent.fetch()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.character_characters.tr()),
        ),
        body: BlocBuilder<CharacterListBloc, CharacterListState>(
          builder: (context, state) {
            if (state.initial) {
              return const Center(child: AppLoadingAnimation());
            }

            return InfiniteList(
              itemBuilder: (context, index) => CharacterListTile(
                key: ValueKey(state.data[index].id),
                state.data[index],
                onPressed: () => context
                    .pushRoute(CharacterDetailsRoute(id: state.data[index].id)),
              ),
              itemsCount: state.data.length,
              loadMore: () => context
                  .read<CharacterListBloc>()
                  .add(CharacterListEvent.fetch()),
              isLoading: state.status.isLoading,
              hasReachedMax: state.hasReachedMax,
              error: state.status.isError ? state.status.error : null,
            );
          },
        ),
      ),
    );
  }
}
