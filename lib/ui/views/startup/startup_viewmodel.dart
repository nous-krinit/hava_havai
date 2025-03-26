import 'package:hava_havai/services/fetch_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:hava_havai/app/app.locator.dart';
import 'package:hava_havai/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _apiService = locator<FetchDataService>();

  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));

    await _apiService.fetchProducts();
    _navigationService.replaceWithHomeView();
  }
}
