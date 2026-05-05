import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartsales/core/network/api_client.dart';
import 'package:smartsales/features/auth/repository/auth_repository.dart';
import 'package:smartsales/features/auth/viewmodel/login_viewmodel.dart';
import 'package:smartsales/features/auth/view/splash_screen.dart';
import 'package:smartsales/features/auth/viewmodel/user_viewmodel.dart';
import 'package:smartsales/features/customers/repository/customer_repository.dart';
import 'package:smartsales/features/customers/viewmodel/customer_viewmodel.dart';
import 'package:smartsales/features/invoice/viewmodel/invoice_list_viewmodel.dart';
import 'package:smartsales/features/invoice/repository/invoice_repository.dart';
import 'package:smartsales/features/invoice/viewmodel/invoice_viewmodel.dart';
import 'package:smartsales/features/products/repository/product_repository.dart';
import 'package:smartsales/features/products/viewmodel/product_viewmodel.dart';

void main() {
  final apiClient = ApiClient();
  final authRepository = AuthRepository(apiClient);
  final custRepository = CustomerRepository(apiClient);
  final productRepository = ProductRepository(apiClient);
  final invoiceRepository = InvoiceRepository(apiClient);
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel(authRepository)),
        ChangeNotifierProvider(
          create: (context) => CustomerViewModel(custRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductViewModel(productRepository),
        ),
        ChangeNotifierProvider(create: (context) => InvoiceViewModel()),
        ChangeNotifierProvider(
          create: (_) => InvoiceListViewModel(invoiceRepository),
        ),
        ChangeNotifierProvider(create: (context) => UserViewModel(authRepository),)
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
    theme: ThemeData(
      scaffoldBackgroundColor:Color(0xFFF2F3F7),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.indigo,
    iconTheme: IconThemeData(color: Colors.white), // icons
    titleTextStyle: TextStyle(
      color: Colors.white, // title text
      fontSize: 19,
      fontWeight: FontWeight.w600,
    ),
  ),
),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
