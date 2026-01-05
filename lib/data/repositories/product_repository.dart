import '../../core/network/api_client.dart';
import '../models/product.dart';

class ProductRepository {
  final ApiClient _apiClient;

  ProductRepository(this._apiClient);

  Future<List<Product>> getProducts() async {
    final data = await _apiClient.get('/products');
    return (data as List).map((e) => Product.fromJson(e)).toList();
  }

  Future<Product> addProduct(Product product) async {
    final data = await _apiClient.post('/products', product.toJson());
    return Product.fromJson(data);
  }

  Future<Product> getProductById(int id) async {
    final data = await _apiClient.get('/products/$id');
    return Product.fromJson(data);
  }

}
