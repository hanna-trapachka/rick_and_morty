import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import 'error_handler/provider/app_error_handler_provider.dart';

Future<void> mainCommon(Flavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  _setupDI(flavor);

  runApp(const App());
}

void _setupDI(Flavor flavor) {
  appLocator.pushNewScope(
    scopeName: unauthScope,
    init: (_) {
      AppDI.initDependencies(appLocator, flavor);
      DataDI.initDependencies(appLocator);
      DomainDI.initDependencies(appLocator);
      NavigationDI.initDependencies(appLocator);
    },
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = appLocator<AppRouter>();

    return EasyLocalization(
      path: AppLocalization.langFolderPath,
      supportedLocales: AppLocalization.supportedLocales,
      fallbackLocale: AppLocalization.fallbackLocale,
      child: Builder(
        builder: (BuildContext context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ThemeBloc()),
              BlocProvider(create: (context) => ConnectivityBloc()),
            ],
            child: BlocBuilder<ThemeBloc, Brightness>(
              builder: (context, state) {
                return AppErrorHandlerProvider(
                  child: MaterialApp.router(
                    debugShowCheckedModeBanner: false,
                    routerConfig: appRouter.config(),
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    theme: AppTheme.light,
                    darkTheme: AppTheme.dark,
                    themeMode: state == Brightness.light
                        ? ThemeMode.light
                        : ThemeMode.dark,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
