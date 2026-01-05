import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/network/api_client.dart';
import 'data/locals/hive_service.dart';
import 'data/models/product.dart';
import 'data/repositories/product_repository.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository(ref.read(apiClientProvider));
});

final productDetailProvider =
FutureProvider.family<Product, int>((ref, id) async {
  final repo = ref.read(productRepositoryProvider);
  return repo.getProducts().then((list) => list.firstWhere((p) => p.id == id));
});

final hiveServiceProvider = Provider((ref) => HiveService());
final favoriteProvider = FutureProvider.family<bool, int>((ref, id) async {
  final hive = ref.read(hiveServiceProvider);
  return hive.isFavorite(id);
});
