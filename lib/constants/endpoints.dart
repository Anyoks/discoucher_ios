class Endpoint {
  static String baseUrl = "http://159.89.103.53/api/v1";

  static String login = "$baseUrl/auth/sign_in";
  static String signUp = "$baseUrl/auth"; //POST
  static String updateProfile = "$baseUrl/auth"; //PATCH

  static String restaurantEstablishments =  "$baseUrl/establishments/restaurants";
  static String hotelEstablishments = "$baseUrl/establishments/hotels";
  static String spaEstablishments = "$baseUrl/establishments/spas";

  static String allVouchers = "$baseUrl/vouchers/all";
  static String restaurantVouchers = "$baseUrl/vouchers/resturants";
  static String hotelVouchers = "$baseUrl/vouchers/hotels";
  static String spaVouchers = "$baseUrl/vouchers/spas";

  static String voucherForEstablishment = "$baseUrl/vouchers/est"; //POST

  static String search = "$baseUrl/search/vouchers"; //POST

  static String favorites = "$baseUrl/favourites";
  static String addFavorite = "$baseUrl/favourites/add";
}
