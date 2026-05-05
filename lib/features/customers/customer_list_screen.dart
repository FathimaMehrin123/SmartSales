// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:smartsales/features/customers/customer_detail_screen.dart';
// import 'package:smartsales/features/customers/customer_viewmodel.dart';

// class CustomerListScreen extends StatefulWidget {
//   const CustomerListScreen({super.key});

//   @override
//   State<CustomerListScreen> createState() => _CustomerListScreenState();
// }

// class _CustomerListScreenState extends State<CustomerListScreen> {

//   @override
//   void initState() {
//     super.initState();

//     // call API once when screen loads
//     Future.microtask(() {
//       context.read<CustomerViewModel>().fetchCustomers();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final viewModel = context.watch<CustomerViewModel>();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Customers"),
//       ),
//       body: Builder(
//         builder: (_) {
//           // 🔄 Loading
//           if (viewModel.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           // ❌ Error
//           if (viewModel.errorMessage != null) {
//             return Center(child: Text(viewModel.errorMessage!));
//           }

//           // 📭 Empty
//           if (viewModel.customers.isEmpty) {
//             return const Center(child: Text("No customers found"));
//           }

//           // 📋 List
//           return ListView.builder(
//             itemCount: viewModel.customers.length,
//             itemBuilder: (context, index) {
//               final customer = viewModel.customers[index];

//               return Card(
//                 margin: const EdgeInsets.symmetric(
//                   horizontal: 12,
//                   vertical: 6,
//                 ),
//                 child: ListTile(
//                   title: Text(customer.name),
//                   subtitle: Text(customer.address),
//                   trailing: Text(customer.phone),
//                   onTap: () {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (_) => CustomerDetailScreen(customer: customer),
//     ),
//   );
// },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }



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

    Future.microtask(() {
      context.read<CustomerViewModel>().fetchCustomers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CustomerViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shops"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Builder(
        builder: (_) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null) {
            return Center(child: Text(viewModel.errorMessage!));
          }

          if (viewModel.customers.isEmpty) {
            return const Center(child: Text("No customers found"));
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: viewModel.customers.length,
            itemBuilder: (context, index) {
              final customer = viewModel.customers[index];

              return Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            CustomerDetailScreen(customer: customer),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey.shade400,
                            size: 30,
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                customer.name,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "Address:${customer.address.isEmpty ? 'N/A' : customer.address}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Contact:${customer.phone.isEmpty ? 'N/A' : customer.phone}",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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