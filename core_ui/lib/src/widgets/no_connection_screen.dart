import 'package:core/core.dart';
import 'package:flutter/material.dart';

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          LocaleKeys.general_check_connectivity.tr(),
          style: context.textTheme.labelMedium!.copyWith(
            color: context.colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
