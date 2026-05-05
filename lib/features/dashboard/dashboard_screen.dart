import 'package:flutter/material.dart';
import 'package:smartsales/features/customers/customer_list_screen.dart';
import 'package:smartsales/features/invoice/invoice_list_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text("Hello Sales", style: TextStyle(color: Colors.white)),
        leading: const Icon(Icons.menu),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: Center(
        child: Column(
          
          children: [
            const SizedBox(height: 10),
        
            // Title
            const Text(
              "Mobiz Demo",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.indigo,
              ),
            ),
        SizedBox(height: 40),
            _buildMenuButton(
              icon: Icons.group,
              label: "Customer",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CustomerListScreen()),
                );
              },
            ),
        
            const SizedBox(height: 20),
        
            _buildMenuButton(
              icon: Icons.receipt_long,
              label: "Invoices",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const InvoiceListScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.indigo.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
