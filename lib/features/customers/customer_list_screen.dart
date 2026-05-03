import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartsales/features/customers/customer_detail_screen.dart';
import 'package:smartsales/features/customers/customer_viewmodel.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {

  @override
  void initState() {
    super.initState();

    // call API once when screen loads
    Future.microtask(() {
      context.read<CustomerViewModel>().fetchCustomers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CustomerViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Customers"),
      ),
      body: Builder(
        builder: (_) {
          // 🔄 Loading
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // ❌ Error
          if (viewModel.errorMessage != null) {
            return Center(child: Text(viewModel.errorMessage!));
          }

          // 📭 Empty
          if (viewModel.customers.isEmpty) {
            return const Center(child: Text("No customers found"));
          }

          // 📋 List
          return ListView.builder(
            itemCount: viewModel.customers.length,
            itemBuilder: (context, index) {
              final customer = viewModel.customers[index];

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: ListTile(
                  title: Text(customer.name),
                  subtitle: Text(customer.address),
                  trailing: Text(customer.phone),
                  onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => CustomerDetailScreen(customer: customer),
    ),
  );
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