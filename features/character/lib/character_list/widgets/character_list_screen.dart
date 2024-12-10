import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/character_list_bloc.dart';
import 'character_filters.dart';
import 'character_list_content.dart';

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
                  const CharacterFilters(),
                  BlocBuilder<CharacterListBloc, CharacterListState>(
                    builder: (context, state) {
                      return switch (state) {
                        CharacterListFreshLoading() => const Expanded(
                            child: Center(child: AppLoadingAnimation()),
                          ),
                        CharacterListError(:final error) =>
                          ErrorContainer(error),
                        CharacterListIdle(:final data, :final hasReachedMax) =>
                          CharacterListContent(
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
