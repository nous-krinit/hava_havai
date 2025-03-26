import 'package:stacked/stacked.dart';

import '../../../models/product.dart';

class CartViewModel extends BaseViewModel {

  final List<Product> products;
  final List<int> addedQuantity;
  CartViewModel({required this.products, required this.addedQuantity});

  void addQuantity(int index) {
    addedQuantity[index] += 1;
    rebuildUi();
  }

  void removeQuantity(int index) {
    addedQuantity[index] -= 1;
    if(addedQuantity[index] == 0){
      products.remove(products[index]);
    }
    rebuildUi();
  }
}
