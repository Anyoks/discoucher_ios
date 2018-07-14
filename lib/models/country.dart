class Country {
  final String name;
  final String alpha2Code;
  final String capital;
  final String region;
  final String flag;
  final String cioc;

  Country.fromJsonMap(Map map)
      : name = map['name'],
        alpha2Code = map['alpha2Code'],
        capital = map['capital'],
        region = map['region'],
        flag = map['flag'],
        cioc = map['cioc'];
}
