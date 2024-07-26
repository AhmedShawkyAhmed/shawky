import 'package:shawky/features/profiles/cubit/profiles_cubit.dart';
import 'package:shawky/features/profiles/data/models/profile_model.dart';

class ProfilesArguments {
  final ProfilesCubit cubit;
  final String title;
  final ProfileModel? model;

  ProfilesArguments({
    required this.cubit,
    required this.title,
    this.model,
  });
}
