import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartsales/features/customers/customer_model.dart';
import 'package:smartsales/features/invoice/cart_item_model.dart';
import 'package:smartsales/features/invoice/invoice_viewmodel.dart';
import 'package:smartsales/features/products/product_list_screen.dart';

class CreateInvoiceScreen extends StatelessWidget {
  final CustomerModel customer;

  const CreateInvoiceScreen({
    super.key,
    required this.customer,
  });

  @override
  Widget build(BuildContext context) {
    final invoiceVm = context.watch<InvoiceViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sale"),
        actions: [
          IconButton(
           onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const ProductListScreen(),
    ),
  );
},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: Text(
              customer.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ChoiceChip(
                  label: const Text("VAT"),
                  selected: invoiceVm.isVatEnabled,
                  onSelected: (_) {
                    invoiceVm.changeVatStatus(true);
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text("NO VAT"),
                  selected: !invoiceVm.isVatEnabled,
                  onSelected: (_) {
                    invoiceVm.changeVatStatus(false);
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: invoiceVm.cartItems.isEmpty
                ? const Center(
                    child: Text("No products added"),
                  )
                : ListView.builder(
                    itemCount: invoiceVm.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = invoiceVm.cartItems[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.productName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                "Rate: ${item.rate.toStringAsFixed(2)} | Qty: ${item.quantity} | Amt: ${item.amount.toStringAsFixed(2)}",
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      invoiceVm.decreaseQuantity(item.productId);
                                    },
                                    icon: const Icon(Icons.remove),
                                  ),
                                  Text(item.quantity.toString()),
                                  IconButton(
                                    onPressed: () {
                                      invoiceVm.increaseQuantity(item.productId);
                                    },
                                    icon: const Icon(Icons.add),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      invoiceVm.removeProduct(item.productId);
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),

          _buildTotalSection(invoiceVm),

          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: invoiceVm.cartItems.isEmpty
                    ? null
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Invoice ready to save"),
                          ),
                        );
                      },
                child: const Text("SAVE"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalSection(InvoiceViewModel invoiceVm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("Total: ${invoiceVm.total.toStringAsFixed(2)}"),
          Text("Tax: ${invoiceVm.tax.toStringAsFixed(2)}"),
          Text("Round off: ${invoiceVm.roundOff.toStringAsFixed(2)}"),
          Text(
            "Grand Total: ${invoiceVm.grandTotal.toStringAsFixed(2)}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _addDummyProduct(BuildContext context) {
    context.read<InvoiceViewModel>().addProduct(
          CartItemModel(
            productId: 12815,
            productName: "AL BAKER CHAKKI FRESH ATTA 5 KG",
            rate: 12.00,
            quantity: 1,
          ),
        );
  }
}