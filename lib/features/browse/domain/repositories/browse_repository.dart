import 'package:auto_hub_app/features/browse/domain/models/product_part_item.dart';

abstract class BrowseRepository {
  Future<List<ProductPartItem>> getParts();
  
  Future<List<ProductPartItem>> searchParts({
    String? query,
    List<String>? makes,
    List<String>? categories,
    List<String>? conditions,
    double? maxPrice,
  });
  
  Future<List<ProductPartItem>> searchByVin(String vin);
  
  Future<void> toggleFavorite(String partId);
}
