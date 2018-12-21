class PaymentResponse {
  String message;
  bool success;
  String checkoutRequestId;

  PaymentResponse({
    this.message,
    this.success,
    this.checkoutRequestId,
  });

  //creat a payment response object from json
  factory PaymentResponse.fromJson(Map<String, dynamic> json) =>
    new PaymentResponse(
      success: json['success'],
      message: json['message'] == null ?  json['error'] : json['message'] , // if message is null, then assign the error message
      checkoutRequestId: json['checkout_req_id'] ?? null,
  );

  Map<String, dynamic> toJson() => {
      "success": success,
      "message": message,
      "checkoutRequestId": checkoutRequestId,
  };
}
