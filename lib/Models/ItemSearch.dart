class ItemSearch {
  final int itemID;
  final String itemName;
  final double weight;
  double? cal;

  ItemSearch(
      {required this.itemID, required this.itemName, required this.weight, this.cal = 0});

  factory ItemSearch.fromJson(Map<String, dynamic> json) {
    return ItemSearch(
      itemID: json['item_id'],
      itemName: json['item_name'],
      weight: double.parse(json['weight']),
      cal: double.parse(json['cal']),
    );
  }

  @override
  String toString() {
    return itemName;
  }
}
