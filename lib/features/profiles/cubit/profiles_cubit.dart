import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shawky/core/services/navigation_service.dart';
import 'package:shawky/core/utils/enums.dart';
import 'package:shawky/core/utils/shared_functions.dart';
import 'package:shawky/features/profiles/database/profiles_database.dart';
import 'package:shawky/features/profiles/models/profile_model.dart';

part 'profiles_state.dart';

class ProfilesCubit extends Cubit<ProfilesState> {
  ProfilesCubit(this.database) : super(ProfilesInitial());

  final ProfilesDatabase database;

  TextEditingController nameController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  ProfileType profileType = ProfileType.facebook;

  List<ProfileModel> profileList = [];

  void changeProfileType(value) {
    profileType = value;
    printLog(profileType);
  }

  void dispose() {
    nameController = TextEditingController();
    linkController = TextEditingController();
  }

  Future emitGetProfiles() async {
    try {
      emit(GetProfileLoading());
      profileList = await database.getProfiles();
      emit(GetProfileSuccess());
    } catch (e) {
      emit(GetProfileError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }

  Future emitAddProfile() async {
    try {
      ProfileModel profileModel = ProfileModel(
        name: nameController.text,
        link: linkController.text,
        type: profileType,
      );
      emit(AddProfileLoading());
      await database.addProfile(profileModel);
      emit(AddProfileSuccess());
      emitGetProfiles();
      showMyToast(message: "Profile Added Successfully", success: true);
      dispose();
      NavigationService.pop();
    } catch (e) {
      emit(AddProfileError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }

  Future emitUpdateProfile({
    required ProfileModel model,
  }) async {
    try {
      ProfileModel profileModel = ProfileModel(
        id: model.id,
        name: nameController.text.isEmpty ? model.name : nameController.text,
        link: linkController.text.isEmpty ? model.link : linkController.text,
        type: model.type,
      );
      emit(UpdateProfileLoading());
      await database.updateProfile(profileModel);
      emit(UpdateProfileSuccess());
      int index = profileList.indexOf(model);
      profileList.removeAt(index);
      profileList.insert(index, profileModel);
      showMyToast(message: "Profile Updated Successfully", success: true);
      dispose();
      NavigationService.pop();
    } catch (e) {
      emit(UpdateProfileError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }

  Future emitDeleteProfile({
    required int profileId,
  }) async {
    try {
      emit(DeleteProfileLoading());
      await database.deleteProfile(profileId);
      profileList.removeWhere((element) => element.id == profileId);
      showMyToast(message: "Profile Deleted Successfully", success: true);
      emit(DeleteProfileSuccess());
    } catch (e) {
      emit(DeleteProfileError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }
}
