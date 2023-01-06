class CityModel{
  Map<String,String> city;
  CityModel({
    required this.city
  }){

  }

  @override
  String toString() {
    return city.toString();
  }

}