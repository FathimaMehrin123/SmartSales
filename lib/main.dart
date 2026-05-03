import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartsales/core/network/api_client.dart';
import 'package:smartsales/features/auth/auth_service.dart';
import 'package:smartsales/features/auth/login_viewmodel.dart';
import 'package:smartsales/features/auth/splash_screen.dart';
import 'package:smartsales/features/customers/customer_repository.dart';
import 'package:smartsales/features/customers/customer_viewmodel.dart';
import 'package:smartsales/features/invoice/invoice_viewmodel.dart';
import 'package:smartsales/features/products/product_repository.dart';
import 'package:smartsales/features/products/product_viewmodel.dart';

void main() {
  final apiClient = ApiClient();
  final authRepository = AuthRepository(apiClient);
  final custRepository = CustomerRepository(apiClient);
  final productRepository = ProductRepository(apiClient);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel(authRepository)),
        ChangeNotifierProvider(
          create: (context) => CustomerViewModel(custRepository),
        ),
        ChangeNotifierProvider(create: 
        (context) => InvoiceViewModel()),
        ChangeNotifierProvider(
  create: (_) => ProductViewModel(productRepository),
),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
