class SavingModel {
  int? id;
  String? name;
  num? target;
  num? current;

  SavingModel({
    this.id,
    this.name,
    this.target,
    this.current,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'target': target,
      'current': current,
    };
  }

  @override
  String toString() {
    return 'Account{'
        'id: $id, '
        'name: $name, '
        'target: $target, '
        'current: $current, '
        '}';
  }
}
