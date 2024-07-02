import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shawky/core/services/service_locator.dart';
import 'package:shawky/features/settings/cubit/settings_cubit.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> getSettings() async {
    await getIt<SettingsCubit>().emitGetSettings();
  }
}
