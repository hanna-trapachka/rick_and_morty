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
        body: Column(
          children: [
            const _CharacterFilters(),
            BlocBuilder<CharacterListBloc, CharacterListState>(
              builder: (context, state) {
                if (state.status.isLoading && state.initial) {
                  return const Expanded(
                    child: Center(child: AppLoadingAnimation()),
                  );
                } else {
                  return Expanded(
                    child: InfiniteList(
                      itemBuilder: (context, index) => CharacterListTile(
                        key: ValueKey(state.data[index].id),
                        state.data[index],
                        onPressed: () => context.pushRoute(
                          CharacterDetailsRoute(id: state.data[index].id),
                        ),
                      ),
                      itemsCount: state.data.length,
                      loadMore: () => context
                          .read<CharacterListBloc>()
                          .add(CharacterListEvent.fetch()),
                      isLoading: state.status.isLoading,
                      hasReachedMax: state.hasReachedMax,
                      error: state.status.isError ? state.status.error : null,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CharacterFilters extends StatelessWidget {
  const _CharacterFilters();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterListBloc, CharacterListState>(
      builder: (context, state) {
        final bloc = context.read<CharacterListBloc>();

        return ColoredBox(
          color: context.colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                AppDropdownButton(
                  values: CharacterStatus.values
                      .map((e) => e.name.capitalize())
                      .toList(),
                  selectedValue: state.query.status?.name.capitalize(),
                  onSelected: (value) {
                    late final CharacterStatus? convertedValue;
                    if (value == LocaleKeys.general_all.tr()) {
                      convertedValue = null;
                    } else {
                      convertedValue = CharacterStatus.fromString(value);
                    }
                    bloc.add(
                      CharacterListEvent.filter(
                        species: state.query.species,
                        status: convertedValue,
                      ),
                    );
                  },
                ),
                const Spacer(),
                AppDropdownButton(
                  values: CharacterSpecies.values
                      .map((e) => e.name.capitalize())
                      .toList(),
                  selectedValue: state.query.species?.name.capitalize(),
                  onSelected: (value) {
                    late final CharacterSpecies? convertedValue;
                    if (value == LocaleKeys.general_all.tr()) {
                      convertedValue = null;
                    } else {
                      convertedValue = CharacterSpecies.fromString(value);
                    }
                    bloc.add(
                      CharacterListEvent.filter(
                        species: convertedValue,
                        status: state.query.status,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
