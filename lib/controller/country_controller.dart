import 'package:dev/model/country_model.dart';
import 'package:dev/service/country_api.dart';
import 'package:get/get.dart';


class CountryController extends GetxController {
  var isLoading = true.obs;
  var countrys = <Country>[].obs;

  final CountryApi countryApi = CountryApi();

  @override
  void onInit() {
    fetchCountrys();
    super.onInit();
  }

  void fetchCountrys() async {
    try {
      isLoading(true);
      countrys.value = await countryApi.getCountrys();
    } finally {
      isLoading(false);
    }
  }
}