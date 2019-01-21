class Endpoint {
  static String baseUrl = "http://159.89.103.53/api/v1";

  static String signIn = "$baseUrl/auth/sign_in";
  static String signUp = "$baseUrl/auth"; //POST
  static String updateProfile = "$baseUrl/auth"; //PATCH
  static String bookCode = "$baseUrl/profile/books";

  static String allEstablishments =  "$baseUrl/establishments/est";
  static String singleEstablishment =  "$baseUrl/establishments/get_est"; //POST
  
  static String restaurantEstablishments =  "$baseUrl/establishments/restaurants";
  static String hotelEstablishments = "$baseUrl/establishments/hotels";
  static String spaEstablishments = "$baseUrl/establishments/spas";

  static String allVouchers = "$baseUrl/vouchers/all";
  static String restaurantVouchers = "$baseUrl/vouchers/restaurants";
  static String hotelVouchers = "$baseUrl/vouchers/hotels";
  static String spaVouchers = "$baseUrl/vouchers/spas";

  static String voucherForEstablishment = "$baseUrl/vouchers/est"; //POST

  static String search = "$baseUrl/search/vouchers"; //POST

  static String tags = "$baseUrl/discover/tags"; //GET

  static String favorites = "$baseUrl/favourites";
  static String addFavorite = "$baseUrl/favourites/add";

  static String redeemedOffers = "$baseUrl/profile/redeemed_offers"; // GET

  static String pay = "$baseUrl/pay/mobile"; // POST
  static String checkPayment = "$baseUrl/pay/check_status"; //POST
  static String redeemVoucher = "$baseUrl/redeem/voucher"; // POST

  static String checkUser = "$baseUrl/check"; // POST
}
