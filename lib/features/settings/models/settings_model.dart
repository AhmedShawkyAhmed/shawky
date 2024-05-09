class SettingsModel {
  final int? id;
  final String name;
  final String title;
  final double rate;
  final double gold;

  SettingsModel({
    this.id,
    required this.name,
    required this.title,
    required this.rate,
    required this.gold,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'rate': rate,
      'gold': gold,
    };
  }

  @override
  String toString() {
    return 'Profile{'
        'id: $id, '
        'name: $name, '
        'title: $title, '
        'rate: $rate, '
        'gold: $gold, '
        '}';
  }
}
