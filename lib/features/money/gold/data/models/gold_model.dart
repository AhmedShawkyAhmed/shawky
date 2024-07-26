class GoldModel {
  final int? id;
  final String name;
  final String weight;
  final double price;
  final String date;

  GoldModel({
    this.id,
    required this.name,
    required this.weight,
    required this.price,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'weight': weight,
      'date': date,
    };
  }

  @override
  String toString() {
    return 'Gold{'
        'id: $id, '
        'name: $name, '
        'weight: $weight, '
        'price: $price, '
        'date: $date, '
        '}';
  }
}
