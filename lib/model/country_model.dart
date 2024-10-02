class Country {
  final String name;
  final String flag;
  final String region;
  final String googleMaps;
  final int population;

  Country({
    required this.name,
    required this.flag,
    required this.region,
    required this.googleMaps,
    required this.population,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'],
      flag: json['flags']['png'],
      region: json['region'],
      googleMaps: json['maps']['googleMaps'],
      population: json['population'],
    );
  }
}