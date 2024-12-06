import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';

import '../bloc/character_details_bloc.dart';

@RoutePage()
class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({required this.id, super.key});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CharacterDetailsBloc(appLocator.get<GetCharacterDetailsUseCase>())
            ..add(CharacterDetailsEvent.fetch(id)),
      child: Scaffold(
        appBar: AppBar(
          leading: AppIconButton(
            onPressed: context.maybePop,
            child: const Icon(Icons.arrow_back),
          ),
          title: Text(LocaleKeys.character_details.tr()),
        ),
        body: BlocBuilder<CharacterDetailsBloc, CharacterDetailsState>(
          builder: (context, state) {
            switch (state) {
              case CharacterDetailsLoading():
                return const Center(child: AppLoadingAnimation());
              case CharacterDetailsError(:final error):
                return ErrorContainer(error);
              case CharacterDetailsIdle(:final character):
                return ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      height: 250,
                      decoration: BoxDecoration(
                        color: context.colorScheme.secondaryContainer,
                        image: DecorationImage(
                          image: NetworkImage(character.image),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      character.name,
                      style: context.textTheme.displaySmall!
                          .copyWith(color: context.colorScheme.onSurface),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Other details.....',
                      style: context.textTheme.bodyMedium!
                          .copyWith(color: context.colorScheme.onSurface),
                    ),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}
