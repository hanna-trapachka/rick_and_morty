import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class CharacterListTile extends StatelessWidget {
  const CharacterListTile(
    this.character, {
    this.onPressed,
    this.height = 180,
    super.key,
  });

  final Character character;
  final VoidCallback? onPressed;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(24),
      highlightColor: context.colorScheme.primaryContainer,
      child: Ink(
        height: height,
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            _TileImage(imageUrl: character.image),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      character.name,
                      style: context.textTheme.labelMedium!
                          .copyWith(color: context.colorScheme.onSurface),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: character.status.color,
                          ),
                          width: 6,
                          height: 6,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${character.status.localize()} - ${character.species.localize()}',
                          style: context.textTheme.bodySmall!
                              .copyWith(color: context.colorScheme.onSurface),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      LocaleKeys.character_last_location.tr(),
                      style: context.textTheme.bodySmall!
                          .copyWith(color: context.colorScheme.onSurface),
                    ),
                    Text(
                      character.location.name,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodyMedium!
                          .copyWith(color: context.colorScheme.onSurface),
                    ),
                    const Spacer(),
                    Text(
                      LocaleKeys.character_first_seeing_in.tr(),
                      style: context.textTheme.bodySmall!
                          .copyWith(color: context.colorScheme.onSurface),
                    ),
                    Text(
                      character.origin.name,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodyMedium!
                          .copyWith(color: context.colorScheme.onSurface),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TileImage extends StatelessWidget {
  const _TileImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.horizontal(left: Radius.circular(24)),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
