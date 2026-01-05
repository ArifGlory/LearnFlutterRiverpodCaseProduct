import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers.dart';

class ProductDetailScreen extends ConsumerWidget {
  final int productId;

  const ProductDetailScreen(this.productId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productDetailProvider(productId));

    return Scaffold(
      appBar: AppBar(title: const Text("Product Detail")),
      body: productState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (product) {
          final favState = ref.watch(favoriteProvider(product.id));

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(product.image, height: 240, fit: BoxFit.cover),
              ),
              const SizedBox(height: 16),

              Text(product.title,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),

              Text(product.description),
              const SizedBox(height: 12),

              Text("\$${product.price}",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              favState.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => const SizedBox(),
                data: (isFav) => ElevatedButton.icon(
                  icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                  label: Text(isFav ? "Remove from Favorite" : "Add to Favorite"),
                  onPressed: () async {
                    await ref.read(hiveServiceProvider).toggleFavorite(product.id);
                    ref.invalidate(favoriteProvider(product.id));
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
