class Item {
  final String itemName;
  final String itemDesc;
  final double weight;

  Item({required this.itemName, required this.itemDesc, required this.weight});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      itemName: json['item_name'],
      itemDesc: json['item_desc'],
      weight: json['weight'].toDouble(),
    );
  }
}