import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shawky/core/resources/globals.dart';
import 'package:shawky/core/services/navigation_service.dart';
import 'package:shawky/core/utils/shared_functions.dart';
import 'package:shawky/features/settings/database/settings_database.dart';
import 'package:shawky/features/settings/models/settings_model.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());
  TextEditingController nameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController goldController = TextEditingController();

  List<SettingsModel> settingsList = [];

  void dispose() {
    nameController = TextEditingController();
    titleController = TextEditingController();
    rateController = TextEditingController();
    goldController = TextEditingController();
  }

  Future emitGetSettings() async {
    try {
      emit(GetSettingsLoading());
      settingsList = await SettingsDatabase.getSettings();
      Globals.settings = settingsList.isEmpty ? null : settingsList.first;
      emit(GetSettingsSuccess());
      WidgetsBinding.instance.reassembleApplication();
    } catch (e) {
      emit(GetSettingsError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }

  Future emitAddSettings() async {
    try {
      SettingsModel settingsModel = SettingsModel(
        name: nameController.text,
        title: titleController.text,
        rate: double.parse(rateController.text),
        gold: double.parse(goldController.text),
      );
      emit(AddSettingsLoading());
      await SettingsDatabase.addSettings(settingsModel);
      emit(AddSettingsSuccess());
      await emitGetSettings();
      showMyToast(message: "Settings Added Successfully", success: true);
      dispose();
      NavigationService.pop();
    } catch (e) {
      emit(AddSettingsError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }

  Future emitUpdateSettings({
    required SettingsModel model,
  }) async {
    try {
      SettingsModel settingsModel = SettingsModel(
        id: model.id,
        name: nameController.text.isEmpty ? model.name : nameController.text,
        title:
            titleController.text.isEmpty ? model.title : titleController.text,
        rate: rateController.text.isEmpty
            ? model.rate
            : double.parse(rateController.text),
        gold: goldController.text.isEmpty
            ? model.gold
            : double.parse(goldController.text),
      );
      emit(UpdateSettingsLoading());
      await SettingsDatabase.updateSettings(settingsModel);
      emit(UpdateSettingsSuccess());
      await emitGetSettings();
      showMyToast(message: "Settings Updated Successfully", success: true);
      dispose();
      NavigationService.pop();
    } catch (e) {
      emit(UpdateSettingsError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }

  Future emitDeleteSettings({
    required int settingsId,
  }) async {
    try {
      emit(DeleteSettingsLoading());
      await SettingsDatabase.deleteSettings(settingsId);
      settingsList.removeWhere((element) => element.id == settingsId);
      showMyToast(message: "Settings Deleted Successfully", success: true);
      emit(DeleteSettingsSuccess());
    } catch (e) {
      emit(DeleteSettingsError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }
}
