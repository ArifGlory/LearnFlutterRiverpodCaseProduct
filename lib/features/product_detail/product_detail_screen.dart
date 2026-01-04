import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers.dart';

class ProductDetailScreen extends ConsumerWidget {
  final int productId;

  const ProductDetailScreen(this.productId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productDetailProvider(productId));

    return Scaffold(
      appBar: AppBar(title: const Text("Product Detail")),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (product) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Image.network(product.image, height: 200),
              const SizedBox(height: 16),
              Text(product.title, style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 8),
              Text(product.description),
              const SizedBox(height: 8),
              Text("\$${product.price}",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
