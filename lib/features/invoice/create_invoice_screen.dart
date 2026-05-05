// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:smartsales/core/network/api_client.dart';
// import 'package:smartsales/features/customers/customer_model.dart';
// import 'package:smartsales/features/invoice/invoice_repository.dart';
// import 'package:smartsales/features/invoice/invoice_viewmodel.dart';
// import 'package:smartsales/features/products/product_list_screen.dart';

// class CreateInvoiceScreen extends StatelessWidget {
//   final CustomerModel customer;

//   const CreateInvoiceScreen({
//     super.key,
//     required this.customer,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final invoiceVm = context.watch<InvoiceViewModel>();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Sale"),
//         actions: [
//           IconButton(
//            onPressed: () {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (_) => const ProductListScreen(),
//     ),
//   );
// },
//             icon: const Icon(Icons.add),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(12),
//             child: Text(
//               customer.name,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),

//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 ChoiceChip(
//                   label: const Text("VAT"),
//                   selected: invoiceVm.isVatEnabled,
//                   onSelected: (_) {
//                     invoiceVm.changeVatStatus(true);
//                   },
//                 ),
//                 const SizedBox(width: 8),
//                 ChoiceChip(
//                   label: const Text("NO VAT"),
//                   selected: !invoiceVm.isVatEnabled,
//                   onSelected: (_) {
//                     invoiceVm.changeVatStatus(false);
//                   },
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 10),

//           Expanded(
//             child: invoiceVm.cartItems.isEmpty
//                 ? const Center(
//                     child: Text("No products added"),
//                   )
//                 : ListView.builder(
//                     itemCount: invoiceVm.cartItems.length,
//                     itemBuilder: (context, index) {
//                       final item = invoiceVm.cartItems[index];

//                       return Card(
//                         margin: const EdgeInsets.symmetric(
//                           horizontal: 10,
//                           vertical: 6,
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(10),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 item.productName,
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),

//                               const SizedBox(height: 8),

//                               Text(
//                                 "Rate: ${item.rate.toStringAsFixed(2)} | Qty: ${item.quantity} | Amt: ${item.amount.toStringAsFixed(2)}",
//                               ),

//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   IconButton(
//                                     onPressed: () {
//                                       invoiceVm.decreaseQuantity(item.productId);
//                                     },
//                                     icon: const Icon(Icons.remove),
//                                   ),
//                                   Text(item.quantity.toString()),
//                                   IconButton(
//                                     onPressed: () {
//                                       invoiceVm.increaseQuantity(item.productId);
//                                     },
//                                     icon: const Icon(Icons.add),
//                                   ),
//                                   IconButton(
//                                     onPressed: () {
//                                       invoiceVm.removeProduct(item.productId);
//                                     },
//                                     icon: const Icon(Icons.delete),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           ),

//           _buildTotalSection(invoiceVm),

//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: SizedBox(
//               width: double.infinity,
//               height: 48,
//               child: ElevatedButton(
//                onPressed: invoiceVm.cartItems.isEmpty
//     ? null
//     : () async {
//         final prefs = await SharedPreferences.getInstance();

//         final userId = prefs.getInt('user_id') ?? 0;
//         final storeId = prefs.getInt('store_id') ?? 0;

//         final payload = await context
//             .read<InvoiceViewModel>()
//             .buildInvoicePayload(
//               customerId: customer.id,
//               userId: userId,
//               storeId: storeId,
//             );

//         print("Payload: $payload");

//         final apiClient = ApiClient(); // ⚠️ temp (see note below)
//         final repo = InvoiceRepository(apiClient);

//         await repo.createInvoice(payload);
// context.read<InvoiceViewModel>().clearCart();

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Invoice Created Successfully")),
//         );
//         Navigator.pop(context);
//       },
//                 child: const Text("SAVE"),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTotalSection(InvoiceViewModel invoiceVm) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Text("Total: ${invoiceVm.total.toStringAsFixed(2)}"),
//           Text("Tax: ${invoiceVm.tax.toStringAsFixed(2)}"),
//           Text("Round off: ${invoiceVm.roundOff.toStringAsFixed(2)}"),
//           Text(
//             "Grand Total: ${invoiceVm.grandTotal.toStringAsFixed(2)}",
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

 
// }





import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartsales/core/network/api_client.dart';
import 'package:smartsales/features/customers/customer_model.dart';
import 'package:smartsales/features/invoice/invoice_repository.dart';
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    customer.name.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ChoiceChip(
                  label: const Text("VAT"),
                  selected: invoiceVm.isVatEnabled,
                  onSelected: (_) {
                    invoiceVm.changeVatStatus(true);
                  },
                ),
                const SizedBox(width: 4),
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
                          horizontal: 8,
                          vertical: 5,
                        ),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.productName.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
"${item.productTypeName} | ${item.unitName} | Qty: ${item.quantity} | Rate: ${item.rate.toStringAsFixed(2)} | Amt: ${item.amount.toStringAsFixed(2)}",                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: 2,
                              top: 2,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                  size: 20,
                                ),
                                onPressed: () {
                                  invoiceVm.removeProduct(item.productId);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text("Remarks"),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SizedBox(
                        height: 38,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Text("Discount"),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text("AMOUNT"),
                      selected: true,
                      onSelected: (_) {},
                    ),
                    const SizedBox(width: 4),
                    ChoiceChip(
                      label: const Text("PERCENTAGE"),
                      selected: false,
                      onSelected: (_) {},
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: SizedBox(
                        height: 38,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          _buildTotalSection(invoiceVm),

          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: 150,
              height: 45,
              child: ElevatedButton(
                onPressed: invoiceVm.cartItems.isEmpty
                    ? null
                    : () async {
                        final prefs = await SharedPreferences.getInstance();

                        final userId = prefs.getInt('user_id') ?? 0;
                        final storeId = prefs.getInt('store_id') ?? 0;

                        final payload = await context
                            .read<InvoiceViewModel>()
                            .buildInvoicePayload(
                              customerId: customer.id,
                              userId: userId,
                              storeId: storeId,
                            );

                        print("Payload: $payload");

                        final apiClient = ApiClient();
                        final repo = InvoiceRepository(apiClient);

                        await repo.createInvoice(payload);

                        context.read<InvoiceViewModel>().clearCart();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Invoice Created Successfully"),
                          ),
                        );

                        Navigator.pop(context);
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("Total: ${invoiceVm.total.toStringAsFixed(2)}"),
            Text("Tax: ${invoiceVm.tax.toStringAsFixed(2)}"),
            Text("Round off: ${invoiceVm.roundOff.toStringAsFixed(2)}"),
            Text(
              "Grand Total: ${invoiceVm.grandTotal.toStringAsFixed(2)}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}