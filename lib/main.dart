import 'dart:async';

import 'package:finance/core/components/app/app.dart';
import 'package:finance/core/services/database_service.dart';
import 'package:finance/core/services/my_bloc_observer.dart';
import 'package:finance/core/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

late Timer timer;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await DatabaseService.init();
  // await PrivacyService.init();
  await initAppModule();

  runApp(
    MyApp(),
  );
}
