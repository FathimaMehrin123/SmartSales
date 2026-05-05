import 'package:flutter/material.dart';
import 'package:smartsales/features/customers/model/customer_model.dart';
import 'package:smartsales/features/invoice/view/create_invoice_screen.dart';

class CustomerDetailScreen extends StatelessWidget {
  final CustomerModel customer;

  const CustomerDetailScreen({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customers"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15,left: 10,right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              customer.name.toUpperCase(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        
            const SizedBox(height: 18),
        
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 145,
                  height: 120,
                  color: Colors.grey.shade300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 42,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Image not Found!",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
        
                const SizedBox(width: 18),
        
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _infoRow(
                        icon: Icons.location_on,
                        text: customer.address.isEmpty
                            ? "N/A"
                            : customer.address,
                      ),
                      const SizedBox(height: 12),
                      _infoRow(
                        icon: Icons.phone,
                        text: customer.phone.isEmpty ? "N/A" : customer.phone,
                      ),
                      const SizedBox(height: 12),
                      _infoRow(
                        icon: Icons.email,
                        text: "N/A",
                      ),
                    ],
                  ),
                ),
              ],
            ),
        
            const SizedBox(height: 18),
        
            const Text(
              "Customer Type: CASH",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
        
            
                 const SizedBox(height: 10),
        
            Expanded(
              child: Container(
                color: Colors.white,
                width: double.infinity,
              //   height: MediaQuery.of(
              //  context   
              //   ).size.height*0.6,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CreateInvoiceScreen(customer: customer,),
                        ),
                      );
                    },
                    child: Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.point_of_sale,
                            color: Colors.white,
                            size: 42,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Sale",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        
           
          ],
        ),
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.grey,
          size: 26,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}