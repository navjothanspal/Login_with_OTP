class CsrfTokenResponse {
  final bool success;
  final String? status;
  final String message;
  final String? data;

  CsrfTokenResponse({
    required this.success,
    this.status,
    required this.message,
    this.data,
  });

  // Factory constructor to create an AuthResponse object from JSON
  factory CsrfTokenResponse.fromJson(Map<String, dynamic> json) {
    return CsrfTokenResponse(
      success: json['success'] as bool,
      status: json['status'] as String?,
      message: json['message'] as String,
      data: json['data'] as String?,
    );
  }

  // Method to convert the AuthResponse object back to JSON (optional)
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'status': status,
      'message': message,
      'data': data,
    };
  }
}
