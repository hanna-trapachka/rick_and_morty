import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import 'no_connection_screen.dart';

@RoutePage(name: 'ConnectionWrapperRoute')
class ConnectionWrapper extends StatelessWidget implements AutoRouteWrapper {
  const ConnectionWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    final getConnectivityStatus =
        appLocator.get<GetConnectivityStatusUseCase>();

    return ListenableBuilder(
      listenable: appLocator.get<ConnectivityService>(),
      builder: (BuildContext context, Widget? child) {
        if (!getConnectivityStatus.execute()) {
          return const NoConnectionScreen();
        }

        return const AutoRouter();
      },
    );
  }
}
