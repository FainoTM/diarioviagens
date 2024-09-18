import 'package:dev/model/country_model.dart';
import 'package:dio/dio.dart';


class CountryApi {
  final Dio dio = Dio();
  final String apiLink = 'https://restcountries.com/v3.1/lang/portuguese';


  Future<List<Country>> getCountrys() async {
    try {
      final response = await dio.get(
          apiLink);
      if (response.statusCode == 200) {
        List<Country> countrys = (response.data)
            .map((countryData) => Country.fromJson(countryData))
            .toList();
        return countrys;
      } else {
        throw Exception('Falha ao carregar os livros');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}