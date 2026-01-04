import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'product_list_controller.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productListControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text(err.toString())),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
