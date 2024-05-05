import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/services/navigation_service.dart';
import 'package:shawky/core/utils/shared_functions.dart';
import 'package:shawky/features/money/gold/database/gold_database.dart';
import 'package:shawky/features/money/gold/models/gold_model.dart';

part 'gold_state.dart';

class GoldCubit extends Cubit<GoldState> {
  GoldCubit() : super(GoldInitial());

  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  List<GoldModel> goldList = [];

  dispose() {
    nameController.clear();
    weightController.clear();
    priceController.clear();
    dateController.clear();
  }

  Future<void> selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: NavigationService.context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020, 8),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.blue,
              cardColor: const Color(0xff232323),
              brightness: Brightness.dark,
            ),
            dialogBackgroundColor: ColorManager.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      dateController.text = picked.toString().substring(0, 10);
    }
  }

  Future emitGetGold() async {
    try {
      emit(GetGoldLoading());
      goldList = await GoldDatabase.getGold();
      emit(GetGoldSuccess());
    } catch (e) {
      emit(GetGoldError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }

  Future emitAddGold() async {
    printResponse(dateController.text);
    try {
      GoldModel goldModel = GoldModel(
        name: nameController.text,
        price: double.tryParse(priceController.text)!,
        weight: weightController.text,
        date: dateController.text.isEmpty
            ? DateTime.now().toString().substring(0, 10)
            : dateController.text,
      );
      emit(AddGoldLoading());
      await GoldDatabase.addGold(goldModel);
      emit(AddGoldSuccess());
      emitGetGold();
      showMyToast(message: "Gold Added Successfully", success: true);
      dispose();
      NavigationService.pop();
    } catch (e) {
      emit(AddGoldError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }

  Future emitDeleteGold({
    required int goldId,
  }) async {
    try {
      emit(DeleteGoldLoading());
      await GoldDatabase.deleteGold(goldId);
      emitGetGold();
      showMyToast(message: "Gold Deleted Successfully", success: true);
      emit(DeleteGoldSuccess());
    } catch (e) {
      emit(DeleteGoldError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }
}
