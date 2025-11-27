class PaymentResponse {
  final String status;
  final String url;

  const PaymentResponse({
    required this.status,
    required this.url,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      status: json['status'] as String? ?? '',
      url: json['url'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'url': url,
  };

  @override
  String toString() => 'PaymentResponse(status: $status, url: $url)';
}
