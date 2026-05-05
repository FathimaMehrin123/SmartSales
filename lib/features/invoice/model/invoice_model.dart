class InvoiceModel {
  final String invoiceNo;
  final String date;
  final String customer;
  final double total;
  final double roundOff;
  final double vat;
  final double grandTotal;

  InvoiceModel({
    required this.invoiceNo,
    required this.date,
    required this.customer,
    required this.total,
    required this.roundOff,
    required this.vat,
    required this.grandTotal,
  });

 factory InvoiceModel.fromJson(Map<String, dynamic> json) {
  return InvoiceModel(
    invoiceNo: json['invoice_no'] ?? '',
    date: "${json['in_date'] ?? ''} ${json['in_time'] ?? ''}",
    customer: json['customer'] != null && json['customer'].isNotEmpty
        ? json['customer'][0]['name'] ?? 'Unknown'
        : 'Unknown',
    total: double.tryParse(json['total'].toString()) ?? 0,
    roundOff: double.tryParse(json['round_off'].toString()) ?? 0,
    vat: double.tryParse(json['total_tax'].toString()) ?? 0,
    grandTotal: double.tryParse(json['grand_total'].toString()) ?? 0,
  );
}
}