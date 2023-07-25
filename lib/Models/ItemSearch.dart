class ItemSearch {
  final int itemID;
  final String itemName;
  final double weight;

  ItemSearch(
      {required this.itemID, required this.itemName, required this.weight});

  factory ItemSearch.fromJson(Map<String, dynamic> json) {
    return ItemSearch(
      itemID: json['item_id'],
      itemName: json['item_name'],
      weight: double.parse(json['weight']),
    );
  }

  @override
  String toString() {
    return itemName;
  }
}
