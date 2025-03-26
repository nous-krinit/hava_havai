import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:hava_havai/ui/common/app_colors.dart';
import 'package:hava_havai/ui/common/ui_helpers.dart';

import '../../common/app_text_styles.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Catalogue'),
        backgroundColor: appBarColor,
        centerTitle: true,
        actions: [
          Stack(
            children: <Widget>[
              IconButton(
                  onPressed: (){}, icon: Icon(Icons.shopping_cart)
              ),
              Positioned(
                right: 11,
                top: 11,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 15,
                    minHeight: 15,
                  ),
                  child: Text(
                    '${viewModel.cartValue}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.5,
        ),
        itemCount: viewModel.products.length,
        itemBuilder: (context, index) {
          final product = viewModel.products[index];
          double discount = product.discountPercentage;
          String discountedPrice = (product.price *(1-discount/100)).toStringAsFixed(2);
          int quantity = viewModel.addedQuantity[index];
          return Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(
                        product.thumbnail,
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 10,
                      child: quantity == 0
                          ? ElevatedButton(
                        onPressed: () {viewModel.addQuantity(index);},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.pinkAccent,
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 4,
                        ),
                        child: Text("Add"),
                      ) 
                          :ElevatedButton(
                          onPressed: (){},
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
                                onPressed: () {viewModel.removeQuantity(index);},
                              ),
                              Text("$quantity"),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {viewModel.addQuantity(index);},
                              ),
                            ],
                          ),
                      )
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(product.brand ?? 'Generic', style: const TextStyle(color: Colors.grey)),
                      verticalSpaceSmall,
                      Row(
                        children: [
                          Text(
                            '₹$discountedPrice',
                            style: TextStyles.discountedPrice,
                          ),
                          horizontalSpaceSmall,
                          Text(
                            '₹${product.price.toStringAsFixed(2)}',
                            style: TextStyles.realPrice
                          ),
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
                          style:
                          TextStyles.highlight,
                        ),
                      ])),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
