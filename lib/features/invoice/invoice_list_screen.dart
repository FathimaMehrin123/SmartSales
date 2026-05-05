import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartsales/features/invoice/invoice_list_viewmodel.dart';

class InvoiceListScreen extends StatefulWidget {
  const InvoiceListScreen({super.key});

  @override
  State<InvoiceListScreen> createState() => _InvoiceListScreenState();
}

class _InvoiceListScreenState extends State<InvoiceListScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<InvoiceListViewModel>().fetchInvoices();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<InvoiceListViewModel>();

    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.indigo,
        title: const Text("Sales Invoice",style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(

            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Builder(
        builder: (_) {

          // 🔄 Loading
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // ❌ Error
          if (vm.error != null) {
            return Center(child: Text(vm.error!));
          }

          // 📭 Empty
          if (vm.invoices.isEmpty) {
            return const Center(child: Text("No invoices found"));
          }

          // 📋 List
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: vm.invoices.length,
            itemBuilder: (context, index) {
              final invoice = vm.invoices[index];

              return Card(
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${invoice.invoiceNo} | ${invoice.date}",
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 6),

                      Text(
                        invoice.customer,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),

                      Text("Total: ${invoice.total}"),
                      const SizedBox(height: 12),

                      Text("Round off: ${invoice.roundOff}"),
                      const SizedBox(height: 12),

                      Text("Total Vat: ${invoice.vat}"),
                      Text("Grand Total: ${invoice.grandTotal}"),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}