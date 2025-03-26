import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/product.dart';
import '../../common/app_colors.dart';
import '../../common/app_text_styles.dart';
import '../../common/ui_helpers.dart';
import 'cart_viewmodel.dart';

class CartView extends StackedView<CartViewModel> {
  final List<Product> products;
  final List<int> addedQuantities;

  const CartView(
      {Key? key, required this.products, required this.addedQuantities})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CartViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: appBarColor,
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: viewModel.products.length,
        itemBuilder: (context, index) {
          final product = viewModel.products[index];
          double discount = product.discountPercentage;
          String discountedPrice =
              (product.price * (1 - discount / 100)).toStringAsFixed(2);
          int quantity = viewModel.addedQuantity[index];
          return Card(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    product.thumbnail,
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.title,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(product.brand ?? 'Generic',
                          style: const TextStyle(color: Colors.grey)),
                      verticalSpaceSmall,
                      Row(
                        children: [
                          Text(
                            '₹$discountedPrice',
                            style: TextStyles.discountedPrice,
                          ),
                          horizontalSpaceSmall,
                          Text('₹${product.price.toStringAsFixed(2)}',
                              style: TextStyles.realPrice),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: '${discount.toStringAsFixed(2)}% ',
                          style: TextStyles.highlight.copyWith(fontSize: 12),
                        ),
                        TextSpan(
                          text: 'OFF',
                          style: TextStyles.highlight,
                        ),
                      ])),
                    verticalSpaceSmall,
                    quantity == 0
                        ? SizedBox.shrink()
                        : ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.pinkAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 4,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              viewModel.removeQuantity(index);
                            },
                          ),
                          Text("$quantity"),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              viewModel.addQuantity(index);
                            },
                          ),
                        ],
                      ),
                    )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(TextSpan(children: [
              TextSpan(
                text: 'Amount Price: ',
              ),
              TextSpan(
               text:   '${viewModel.products.asMap().entries.fold<double>(0, (sum, entry) {
                   int index = entry.key;
                   var product = entry.value;
                   int quantity = viewModel.addedQuantity[index];
                   return sum + (product.price * (1 - product.discountPercentage / 100) * quantity);
                 },
               ).toStringAsFixed(2)}',
                style: TextStyles.highlight,
              ),
            ])),
            ElevatedButton(
                onPressed: (){},
                child: Text("CheckOut"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 4,
                padding: EdgeInsets.symmetric(horizontal: 8),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  CartViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CartViewModel(products: products, addedQuantity: addedQuantities);
}
