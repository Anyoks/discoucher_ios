class RedeemResponse {
  String message;
  bool success;
  String vouchers;
  

  RedeemResponse({
    this.message,
    this.success,
    this.vouchers,

  });

  //creat a redeem response object from json
  factory RedeemResponse.fromJson(Map<String, dynamic> json) =>
    new RedeemResponse(
      success: json['success'],
      message: json['message'] == null ?  json['error'] : json['message'] , // if message is null, then assign the error message
      vouchers: json['vouchers'],
  );

  Map<String, dynamic> toJson() => {
      "success": success,
      "message": message,
      "vouchers": vouchers,
  };
}
