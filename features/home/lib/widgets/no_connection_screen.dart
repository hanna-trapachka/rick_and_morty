import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surfaceContainer,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Text(
            LocaleKeys.general_check_connectivity.tr(),
            style: context.textTheme.labelMedium!.copyWith(
              color: context.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
