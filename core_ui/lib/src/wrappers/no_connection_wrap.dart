import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

import '../widgets/no_connection_screen.dart';

class NoConnectionWrap extends StatelessWidget {
  const NoConnectionWrap({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        if (state is ConnectivityFailure) {
          return const NoConnectionScreen();
        }

        return child;
      },
    );
  }
}
