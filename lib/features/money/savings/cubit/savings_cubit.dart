import 'package:bloc/bloc.dart';
import 'package:finance/features/money/savings/data/models/saving_model.dart';
import 'package:flutter/material.dart';

part 'savings_state.dart';

class SavingsCubit extends Cubit<SavingsState> {
  SavingsCubit() : super(SavingsInitial());

  TextEditingController nameController = TextEditingController();
  TextEditingController targetController = TextEditingController();
  TextEditingController currentController = TextEditingController();

  final List<SavingModel> savingList = [
    SavingModel(
      id: 1,
      name: "Apartment",
      current: 100000,
      target: 5000000,
    ),
    SavingModel(
      id: 2,
      name: "Car",
      current: 1000,
      target: 1000000,
    ),
    SavingModel(
      id: 3,
      name: "Villa",
      current: 6000000,
      target: 40000000,
    ),
  ];
}
