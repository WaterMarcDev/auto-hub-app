class ProductPartItem {

  const ProductPartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.condition,
    required this.rating,
    required this.make,
    required this.model,
    required this.yearRange,
    required this.category,
    required this.warranty,
    required this.location,
    required this.imagePath,
    this.tag,
    this.isFavorite = false,
  });
  final String id;
  final String title;
  final double price;
  final String condition;
  final double rating;
  final String make;
  final String model;
  final String yearRange;
  final String category;
  final String warranty;
  final String location;
  final String imagePath;
  final String? tag;
  final bool isFavorite;

  ProductPartItem copyWith({
    bool? isFavorite,
  }) {
    return ProductPartItem(
      id: id,
      title: title,
      price: price,
      condition: condition,
      rating: rating,
      make: make,
      model: model,
      yearRange: yearRange,
      category: category,
      warranty: warranty,
      location: location,
      imagePath: imagePath,
      tag: tag,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
