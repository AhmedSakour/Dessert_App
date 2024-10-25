class DessertModel {
  final String image;
  final String price;
  final String description;
  final String name;
  final List<String> viewedBy;
  final String id;

  DessertModel(
      {required this.image,
      required this.id,
      required this.viewedBy,
      required this.price,
      required this.description,
      required this.name});

  factory DessertModel.fromfireStore(Map<String, dynamic> json) {
    return DessertModel(
        id: json['id'],
        viewedBy: List<String>.from(json['ViewedBy'] ?? []),
        image: json['Image'],
        price: json['Price'],
        description: json['Detail'],
        name: json['Name']);
  }
}
