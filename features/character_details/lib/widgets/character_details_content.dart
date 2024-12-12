import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class CharacterDetailsContent extends StatelessWidget {
  const CharacterDetailsContent(this.character, {super.key});

  final CharacterDetails character;

  @override
  Widget build(BuildContext context) {
    final labelTextStyle = context.textTheme.labelSmall!
        .copyWith(color: context.colorScheme.onSurface);
    final bodyTextStyle = context.textTheme.bodyMedium!
        .copyWith(color: context.colorScheme.onSurface);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        CachedNetworkImage(
          imageUrl: character.image,
          fit: BoxFit.fitWidth,
        ),
        const SizedBox(height: 8),
        Text(
          character.name,
          style: context.textTheme.displaySmall!
              .copyWith(color: context.colorScheme.onSurface),
        ),
        const SizedBox(height: 8),
        Text(LocaleKeys.character_details_status.tr(), style: labelTextStyle),
        const SizedBox(height: 4),
        Text(character.status.localize(), style: bodyTextStyle),
        const SizedBox(height: 8),
        Text(LocaleKeys.character_details_species.tr(), style: labelTextStyle),
        const SizedBox(height: 4),
        Text(character.species.localize(), style: bodyTextStyle),
        const SizedBox(height: 8),
        Text(
          LocaleKeys.character_details_last_location.tr(),
          style: labelTextStyle,
        ),
        const SizedBox(height: 4),
        Text(character.location.name, style: bodyTextStyle),
        const SizedBox(height: 8),
        Text(
          LocaleKeys.character_details_first_seeing_in.tr(),
          style: labelTextStyle,
        ),
        const SizedBox(height: 4),
        Text(character.origin.name, style: bodyTextStyle),
      ],
    );
  }
}
