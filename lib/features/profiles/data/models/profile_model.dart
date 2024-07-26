import 'package:shawky/core/utils/enums.dart';

class ProfileModel {
  final int? id;
  final String name;
  final ProfileType type;
  final String link;

  ProfileModel({
    this.id,
    required this.name,
    required this.type,
    required this.link,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type.name,
      'link': link,
    };
  }

  @override
  String toString() {
    return 'Profile{'
        'id: $id, '
        'name: $name, '
        'type: $type, '
        'link: $link, '
        '}';
  }
}
