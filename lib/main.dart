import 'dart:async';
import 'package:shawky/core/database/firebase_database.dart';
import 'package:shawky/core/services/my_bloc_observer.dart';
import 'package:shawky/core/components/app/app.dart';
import 'package:shawky/core/database/local_database.dart';
import 'package:shawky/core/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

late Timer timer;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await FirebaseDatabase.init();
  await LocalDatabase.init();
  // await PrivacyService.init();
  await initAppModule();

  runApp(
    MyApp(),
  );
}
