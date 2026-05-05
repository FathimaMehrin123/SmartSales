import 'package:flutter/material.dart';
import 'package:smartsales/features/invoice/viewmodel/invoice_viewmodel.dart';

class TotalSectionWidget extends StatelessWidget {
  final InvoiceViewModel invoiceVm;

  const TotalSectionWidget({
    super.key,
    required this.invoiceVm,
  });

  @override
  Widget build(BuildContext context) {
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