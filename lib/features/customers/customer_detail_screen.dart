import 'package:flutter/material.dart';
import 'package:smartsales/features/customers/customer_model.dart';
import 'package:smartsales/features/invoice/create_invoice_screen.dart';

class CustomerDetailScreen extends StatelessWidget {
  final CustomerModel customer;

  const CustomerDetailScreen({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🧾 Customer Info
            Text(
              customer.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text("Phone: ${customer.phone}"),
            const SizedBox(height: 8),
            Text("Address: ${customer.address}"),

            const Spacer(),

            // 🚀 Start Sale Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          CreateInvoiceScreen(customer: customer),
                    ),
                  );
                },
                child: const Text("Start Sale"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}