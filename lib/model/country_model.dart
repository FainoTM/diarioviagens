class Country {
  final String name;
  final String flag;
  final String currency;
  final String capital;
  final String region;
  final String maps;

  Country({
    required this.name,
    required this.flag,
    required this.currency,
    required this.capital,
    required this.region,
    required this.maps
});

  factory Country.fromJson(json) {
    return Country(
      name: json['name']['common'] ,
      flag: json['flags']['png'] ,
      currency: json['currencies'][0] ,
      capital: json['capital'] as String,
      region: json['region'],
      maps: json['maps']['googleMaps']
    );
  }

}