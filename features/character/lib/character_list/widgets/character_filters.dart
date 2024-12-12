import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/character_list_bloc.dart';

class CharacterFilters extends StatelessWidget {
  const CharacterFilters();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterListBloc, CharacterListState>(
      builder: (context, state) {
        final bloc = context.read<CharacterListBloc>();

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          color: context.colorScheme.surface,
          child: Row(
            children: [
              AppDropdownButton(
                values: bloc.statusFilterValues,
                selectedValue: state.query.status?.name.capitalize(),
                onSelected: (value) =>
                    bloc.add(CharacterListEvent.filterByStatus(value)),
              ),
              const Spacer(),
              AppDropdownButton(
                values: bloc.speciesFilterValues,
                selectedValue: state.query.species?.name.capitalize(),
                onSelected: (value) =>
                    bloc.add(CharacterListEvent.filterBySpecies(value)),
              ),
            ],
          ),
        );
      },
    );
  }
}
