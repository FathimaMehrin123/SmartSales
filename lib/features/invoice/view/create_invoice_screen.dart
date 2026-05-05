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
import 'package:smartsales/features/customers/model/customer_model.dart';
import 'package:smartsales/features/invoice/repository/invoice_repository.dart';
import 'package:smartsales/features/invoice/view/widgets/total_section_widget.dart';
import 'package:smartsales/features/invoice/viewmodel/invoice_viewmodel.dart';
import 'package:smartsales/features/products/view/product_list_screen.dart';

class CreateInvoiceScreen extends StatelessWidget {
  final CustomerModel customer;

  const CreateInvoiceScreen({super.key, required this.customer});

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
                MaterialPageRoute(builder: (_) => const ProductListScreen()),
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
                      color: Colors.grey
                    ),
                  ),
                ),
                ChoiceChip(
                  color: WidgetStateProperty.resolveWith<Color>(
  (states) {
    if (states.contains(WidgetState.selected)) {
      return Colors.indigo; // selected color
    }
    return Colors.grey.shade300; // unselected color
  },
),
                  label: const Text("VAT"),
                  selected: invoiceVm.isVatEnabled,
                  onSelected: (_) {
                    invoiceVm.changeVatStatus(true);
                  },
                   showCheckmark: false,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      topRight: Radius.zero,
                      bottomRight: Radius.zero,
                    ),
                  ),
                ),

                ChoiceChip(
                  color: WidgetStateProperty.resolveWith<Color>(
  (states) {
    if (states.contains(WidgetState.selected)) {
      return Colors.indigo; // selected color
    }
    return Colors.grey.shade300; // unselected color
  },
), showCheckmark: false,
                  side: BorderSide(color: Colors.black),
                  label: const Text("NO VAT"),
                  selected: !invoiceVm.isVatEnabled,
                  onSelected: (_) {
                    invoiceVm.changeVatStatus(false);
                  },
                   shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    topLeft  : Radius.zero,
                    bottomLeft  : Radius.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: invoiceVm.cartItems.isEmpty
                ? const Center(child: Text("No products added"))
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
                                    "${item.productTypeName} | ${item.unitName} | Qty: ${item.quantity} | Rate: ${item.rate.toStringAsFixed(2)} | Amt: ${item.amount.toStringAsFixed(2)}",
                                    style: const TextStyle(fontSize: 13),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
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
                ),

                const SizedBox(height: 8),

                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Discount"),
                      const SizedBox(width: 8),
                  
                     ChoiceChip(
                    label: const Text("AMOUNT"),
                    selected: invoiceVm.isDiscountAmount,
                    showCheckmark: false, // ✅ removes tick
                    selectedColor: Colors.indigo,
                    backgroundColor: Colors.grey.shade300,
                    labelStyle: TextStyle(
                      color: invoiceVm.isDiscountAmount ? Colors.white : Colors.black,
                    ),
                    onSelected: (_) {
                      invoiceVm.changeDiscountType(true);
                    },
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        bottomLeft: Radius.circular(6),
                      ),
                    ),
                  ),
                  
                  ChoiceChip(
                    label: const Text("PERCENTAGE"),
                    selected: !invoiceVm.isDiscountAmount,
                    showCheckmark: false, // ✅ removes tick
                    selectedColor: Colors.indigo,
                    backgroundColor: Colors.grey.shade300,
                    labelStyle: TextStyle(
                      color: !invoiceVm.isDiscountAmount ? Colors.white : Colors.black,
                    ),
                    onSelected: (_) {
                      invoiceVm.changeDiscountType(false);
                    },
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(6),
                        bottomRight: Radius.circular(6),
                      ),
                    ),
                  ),
                  
                      const SizedBox(width: 4),
                  
                      Expanded(
                        child: SizedBox(
                          height: 38,
                          child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      invoiceVm.updateDiscount(value);
                    },
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
                )
              ],
            ),
          ),

           TotalSectionWidget(invoiceVm:    invoiceVm),

          Padding(
            padding: const EdgeInsets.all(12),
            child: InkWell(
  onTap: invoiceVm.cartItems.isEmpty
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
  child: Container(
    width: 150,
    height: 45,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: invoiceVm.cartItems.isEmpty
          ? Colors.grey
          : Colors.indigo,
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Text(
      "SAVE",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
          ),
        ],
      ),
    );
  }


}
