import 'nomenclature_item.dart';

class NomenclatureGroup {
  int id = 0;
  String name = '';
  String image = '';
  List<NomenclatureItem> nomenclatureItem = [];

  NomenclatureGroup({
    required this.id,
    required this.name,
    required this.image,
    required this.nomenclatureItem,
  });

  factory NomenclatureGroup.fromJson(Map<String, dynamic> json) {
    final nomenclature = <NomenclatureItem>[];

    if (json['items'] != null) {
      json['items'].forEach((v) {
        nomenclature.add(NomenclatureItem.fromJson(v));
      });
    }

    return NomenclatureGroup(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      nomenclatureItem: nomenclature,
    );
  }

  @override
  String toString() {
    return 'Check{id: $id, name: $name, nomenclatureItem: $nomenclatureItem}';
  }

  NomenclatureGroup.empty() {
    id = 0;
    name = 'Empty';
    image = '';
    nomenclatureItem = [];
  }
}
