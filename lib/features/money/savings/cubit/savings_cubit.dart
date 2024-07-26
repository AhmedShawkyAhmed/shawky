import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shawky/core/services/navigation_service.dart';
import 'package:shawky/core/utils/shared_functions.dart';
import 'package:shawky/features/money/savings/data/database/saving_database.dart';
import 'package:shawky/features/money/savings/data/models/saving_model.dart';

part 'savings_state.dart';

class SavingsCubit extends Cubit<SavingsState> {
  SavingsCubit(this.database) : super(SavingsInitial());

  final SavingsDatabase database;

  TextEditingController nameController = TextEditingController();
  TextEditingController targetController = TextEditingController();
  TextEditingController currentController = TextEditingController();

  List<SavingModel> savingList = [];

  dispose() {
    nameController = TextEditingController();
    targetController = TextEditingController();
    currentController = TextEditingController();
  }

  Future emitGetSavings() async {
    try {
      emit(GetSavingsLoading());
      savingList = await database.getSavings();
      emit(GetSavingsSuccess());
    } catch (e) {
      emit(GetSavingsError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }

  Future emitAddSavings() async {
    try {
      SavingModel savingModel = SavingModel(
        name: nameController.text,
        current: double.tryParse(currentController.text),
        target: double.tryParse(targetController.text),
      );
      emit(AddSavingsLoading());
      await database.addSavings(savingModel);
      emit(AddSavingsSuccess());
      emitGetSavings();
      showMyToast(message: "Savings Added Successfully", success: true);
      dispose();
      NavigationService.pop();
    } catch (e) {
      emit(AddSavingsError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }

  Future emitUpdateSavings({
    required SavingModel model,
  }) async {
    try {
      SavingModel savingModel = SavingModel(
        id: model.id,
        name: nameController.text.isEmpty ? model.name : nameController.text,
        current: currentController.text.isEmpty
            ? model.current
            : double.tryParse(currentController.text),
        target: targetController.text.isEmpty
            ? model.target
            : double.tryParse(targetController.text),
      );
      emit(UpdateSavingsLoading());
      await database.updateSavings(savingModel);
      emit(UpdateSavingsSuccess());
      int index = savingList.indexOf(model);
      savingList.removeAt(index);
      savingList.insert(index, savingModel);
      showMyToast(message: "Savings Updated Successfully", success: true);
      dispose();
      NavigationService.pop();
    } catch (e) {
      emit(UpdateSavingsError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }

  Future emitDeleteSavings({
    required int savingsId,
  }) async {
    try {
      emit(DeleteSavingsLoading());
      await database.deleteSavings(savingsId);
      savingList.removeWhere((element) => element.id == savingsId);
      showMyToast(message: "Savings Deleted Successfully", success: true);
      emit(DeleteSavingsSuccess());
    } catch (e) {
      emit(DeleteSavingsError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }
}
