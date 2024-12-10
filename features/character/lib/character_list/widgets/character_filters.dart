import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
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

        return ColoredBox(
          color: context.colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                AppDropdownButton(
                  // TODO(ann): map values in bloc
                  values: CharacterStatus.values
                      .map((e) => e.name.capitalize())
                      .toList(),
                  selectedValue: state.query.status?.name.capitalize(),
                  onSelected: (value) {
                    // TODO(ann): convert values in bloc
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
