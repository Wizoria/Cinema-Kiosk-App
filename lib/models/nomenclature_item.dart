class NomenclatureItem {
  int id = 0;
  String name = '';
  String image = '';
  double price = 0.0;
  String promoCode = '';

  NomenclatureItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  factory NomenclatureItem.fromJson(Map<String, dynamic> json) {
    return NomenclatureItem(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      price: json['price'] as double,
    );
  }

  @override
  String toString() {
    return 'Nomenclature{id: $id, name: $name, price: $price}';
  }

  NomenclatureItem.empty() {
    id = 0;
    name = 'Empty';
    image = '';
    price = 0.0;
    promoCode = '';
  }
}
