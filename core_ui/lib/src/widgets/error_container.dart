import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ErrorContainer extends StatelessWidget {
  const ErrorContainer(this.error, {super.key});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: context.colorScheme.errorContainer,
      ),
      child: Text(
        error,
        style: context.textTheme.labelMedium!
            .copyWith(color: context.colorScheme.onError),
      ),
    );
  }
}
