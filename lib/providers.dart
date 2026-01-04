import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/network/api_client.dart';
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
