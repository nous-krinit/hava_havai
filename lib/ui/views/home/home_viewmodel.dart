import 'package:hava_havai/app/app.bottomsheets.dart';
import 'package:hava_havai/app/app.dialogs.dart';
import 'package:hava_havai/app/app.locator.dart';
import 'package:hava_havai/models/product.dart';
import 'package:hava_havai/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/fetch_data_service.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _apiService = locator<FetchDataService>();

  List<Product> get products => _apiService.getCachedProducts();
  late List<int> addedQuantity;
  int cartValue = 0;

  HomeViewModel() {
    addedQuantity = List.filled(products.length, 0);
  }

  void addQuantity(int index){
    addedQuantity[index] += 1;
    cartValue += 1 ;
    rebuildUi();
  }

  void removeQuantity(int index){
    addedQuantity[index] -= 1;
    cartValue -= 1 ;
    rebuildUi();
  }


  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: ksHomeBottomSheetTitle,
      description: ksHomeBottomSheetDescription,
    );
  }
}
