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

  String get counterLabel => 'Counter is: $_counter';
  List<Product> get products => _apiService.getCachedProducts();

  int _counter = 0;

  void incrementCounter() {
    _counter++;
    rebuildUi();
  }

  void showDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Stacked Rocks!',
      description: 'Give stacked $_counter stars on Github',
    );
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: ksHomeBottomSheetTitle,
      description: ksHomeBottomSheetDescription,
    );
  }
}
