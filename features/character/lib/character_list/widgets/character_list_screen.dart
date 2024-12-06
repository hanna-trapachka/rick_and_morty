import 'package:auto_route/auto_route.dart';
import 'package:character_details/character_details.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/character_list_bloc.dart';
import 'character_list_tile.dart';

@RoutePage()
class CharacterListScreen extends StatelessWidget {
  const CharacterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharacterListBloc(
        appLocator.get<GetCharacterListUseCase>(),
      )..add(CharacterListEvent.fetch(refresh: true)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.character_characters.tr()),
        ),
        body: BlocBuilder<CharacterListBloc, CharacterListState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async => context
                  .read<CharacterListBloc>()
                  .add(CharacterListEvent.fetch(refresh: true)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _CharacterFilters(),
                  BlocBuilder<CharacterListBloc, CharacterListState>(
                    builder: (context, state) {
                      return switch (state) {
                        CharacterListFreshLoading() => const Expanded(
                            child: Center(child: AppLoadingAnimation()),
                          ),
                        CharacterListError(:final error) =>
                          ErrorContainer(error),
                        CharacterListIdle(:final data, :final hasReachedMax) =>
                          _CharacterListContent(
                            data: data,
                            hasReachedMax: hasReachedMax,
                          ),
                      };
                    },
                  ),
                ],
              ),
            );
          },
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
                      CharacterListEvent.fetch(
                        species: state.query.species,
                        status: convertedValue,
                        refresh: true,
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
                      CharacterListEvent.fetch(
                        species: convertedValue,
                        status: state.query.status,
                        refresh: true,
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

class _CharacterListContent extends StatelessWidget {
  const _CharacterListContent({
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
            CharacterDetailsRoute(
              id: data[index].id,
            ),
          ),
        ),
        itemsCount: data.length,
        loadMore: () =>
            context.read<CharacterListBloc>().add(CharacterListEvent.fetch()),
        hasReachedMax: hasReachedMax,
      ),
    );
  }
}
