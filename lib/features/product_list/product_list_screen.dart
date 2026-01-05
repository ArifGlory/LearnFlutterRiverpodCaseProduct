import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers.dart';
import '../product_detail/product_detail_screen.dart';
import 'product_list_controller.dart';
import 'package:learning_riverpod_flutter/features/add_product/add_product_screen.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productListControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Something went wrong"),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => ref
                    .read(productListControllerProvider.notifier)
                    .refresh(),
                child: const Text("Retry"),
              )
            ],
          ),
        ),

        data: (products) => RefreshIndicator(
          onRefresh: () =>
              ref.read(productListControllerProvider.notifier).refresh(),
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (_, i) {
              final p = products[i];
              return ListTile(
                leading: Image.network(p.image, width: 50),
                title: Text(p.title),
                subtitle: Text("\$${p.price}"),
                onTap: () {
                  ref.read(productDetailProvider(p.id));

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailScreen(p.id),
                    ),
                  );
                },

              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddProductScreen()),
          );
        },
      ),

    );
  }
}
