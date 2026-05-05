import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartsales/features/invoice/model/cart_item_model.dart';
import 'package:smartsales/features/invoice/viewmodel/invoice_viewmodel.dart';
import 'package:smartsales/features/products/viewmodel/product_viewmodel.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final vm = context.read<ProductViewModel>();
      vm.fetchProducts();
      vm.fetchProductTypes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productVm = context.watch<ProductViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Copy Products"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: Builder(
        builder: (_) {
          if (productVm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (productVm.errorMessage != null) {
            return Center(child: Text(productVm.errorMessage!));
          }

          if (productVm.products.isEmpty) {
            return const Center(child: Text("No products found"));
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: productVm.products.length,
            itemBuilder: (context, index) {
              final product = productVm.products[index];

              return Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () async {
                    final qtyController = TextEditingController(text: "1");

                    final productVm = context.read<ProductViewModel>();

                    await productVm.fetchProductDetail(product.id);

                    final productTypes = productVm.productTypes;
                    final productUnits = productVm.productUnits;

                    int selectedProductTypeId = productTypes.isNotEmpty
                        ? productTypes.first.id
                        : 1;

                    String selectedProductTypeName = productTypes.isNotEmpty
                        ? productTypes.first.name
                        : "Normal";

                    int selectedUnitId = productUnits.isNotEmpty
                        ? productUnits.first.unitId
                        : 1529;

                    String selectedUnitName = productUnits.isNotEmpty
                        ? productUnits.first.unitName
                        : "PCS";

                    double selectedPrice = productUnits.isNotEmpty
                        ? productUnits.first.price
                        : product.price;

                    showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${product.code} | ${product.name}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  Container(
                                    height: 80,
                                    width: 80,
                                    color: Colors.grey.shade300,
                                    child: const Icon(Icons.camera_alt),
                                  ),

                                  const SizedBox(height: 16),

                                  /// ✅ UPDATED: Product Type from API
                                  Container(
                                    padding: EdgeInsets.only(left: 8),
                                    color: Colors.grey,
                                    child: DropdownButtonFormField<int>(
                                      initialValue: selectedProductTypeId,
                                      items: productTypes.map((type) {
                                        return DropdownMenuItem<int>(
                                          value: type.id,
                                          child: Text(type.name),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        if (value == null) return;

                                        final selectedType = productTypes
                                            .firstWhere((e) => e.id == value);

                                        setState(() {
                                          selectedProductTypeId = value;
                                          selectedProductTypeName =
                                              selectedType.name;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        labelText: "Product Type",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  /// (no change)
                                  Container(
                                    padding: EdgeInsets.only(left: 8),
                                    color: Colors.grey,
                                    child: DropdownButtonFormField<int>(
                                      initialValue: selectedUnitId,
                                      items: productUnits.map((unit) {
                                        return DropdownMenuItem<int>(
                                          value: unit.unitId,
                                          child: Text(unit.unitName),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        if (value == null) return;

                                        final selectedUnit = productUnits
                                            .firstWhere(
                                              (e) => e.unitId == value,
                                            );

                                        setState(() {
                                          selectedUnitId = value;
                                          selectedUnitName =
                                              selectedUnit.unitName;
                                          selectedPrice = selectedUnit.price;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        labelText: "Unit",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  Container(
                                    padding: EdgeInsets.only(left: 8),
                                    color: Colors.grey,
                                    child: TextFormField(
                                      key: ValueKey(selectedPrice),
                                      initialValue: selectedPrice
                                          .toStringAsFixed(2),
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                        labelText: "Amount",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  Container(
                                    padding: EdgeInsets.only(left: 8),
                                    color: Colors.grey,
                                    child: TextFormField(
                                      controller: qtyController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: "Quantity",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () => Navigator.pop(context),
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            color: Colors.grey,
                                          ),
                                          child: Text(
                                            "Close",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      InkWell(
                                        onTap: () {
                                          context
                                              .read<InvoiceViewModel>()
                                              .addProduct(
                                                CartItemModel(
                                                  productId: product.id,
                                                  productName: product.name,
                                                  rate: selectedPrice,
                                                  quantity:
                                                      int.tryParse(
                                                        qtyController.text,
                                                      ) ??
                                                      1,
                                                  productTypeId:
                                                      selectedProductTypeId,
                                                  productTypeName:
                                                      selectedProductTypeName,
                                                  unitId: selectedUnitId,
                                                  unitName: selectedUnitName,
                                                ),
                                              );

                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            color: Colors.indigo,
                                          ),

                                          child: Text(
                                            "Save",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey.shade400,
                            size: 28,
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Text(
                            "${product.code.isEmpty ? product.id : product.code} | ${product.name.toUpperCase()}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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
