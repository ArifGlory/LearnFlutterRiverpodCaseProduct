import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/product.dart';
import '../product_list/product_list_controller.dart';

class AddProductScreen extends ConsumerWidget {
  AddProductScreen({super.key});

  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Product")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: "Title")),
            TextField(controller: priceController, decoration: const InputDecoration(labelText: "Price"), keyboardType: TextInputType.number),
            TextField(controller: descController, decoration: const InputDecoration(labelText: "Description")),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final product = Product(
                  id: 0,
                  title: titleController.text,
                  description: descController.text,
                  price: double.parse(priceController.text),
                  image: "https://i.pravatar.cc",
                  category: "custom",
                );

                ref.read(productListControllerProvider.notifier).addProduct(product);
                Navigator.pop(context);
              },
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}
