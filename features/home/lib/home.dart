library home;

import 'package:navigation/navigation.dart';

import '../home.gm.dart';

export '../home.gm.dart';
export 'bloc/home_bloc.dart';

@AutoRouterConfig.module()
class HomeModule extends $HomeModule {}
