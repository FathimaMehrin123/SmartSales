import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartsales/features/invoice/cart_item_model.dart';
import 'package:smartsales/features/invoice/invoice_viewmodel.dart';
import 'package:smartsales/features/products/product_viewmodel.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ProductViewModel>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productVm = context.watch<ProductViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      body: Builder(
        builder: (_) {
          if (productVm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (productVm.errorMessage != null) {
            return Center(child: Text(productVm.errorMessage!));
          }

          if (productVm.products.isEmpty) {
            return const Center(child: Text("No products found"));
          }

          return ListView.builder(
            itemCount: productVm.products.length,
            itemBuilder: (context, index) {
              final product = productVm.products[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text("${product.code} | ${product.name}"),
                  subtitle: Text("Rate: ${product.price.toStringAsFixed(2)}"),
                  onTap: () {
                    context.read<InvoiceViewModel>().addProduct(
                          CartItemModel(
                            productId: product.id,
                            productName: product.name,
                            rate: product.price,
                            quantity: 1,
                          ),
                        );

                    Navigator.pop(context);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}