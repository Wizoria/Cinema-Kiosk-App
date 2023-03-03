class TotalItem {
  int id = 0;
  String name = '';
  double price = 0;
  double totalPrice = 0;
  int amount = 0;

  TotalItem({
    required this.id,
    required this.name,
    required this.price,
    required this.totalPrice,
    required this.amount
  });

  @override
  String toString() {
    return 'Nomenclature{id: $id, name: $name, price: $price, amount: $amount}';
  }

  TotalItem.empty() {
    id = 0;
    name = 'Empty';
    price = 0;
    totalPrice = 0;
    amount = 0;
  }
}