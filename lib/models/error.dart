class NewsError {
  final String status;
  final String code;
  final String message;

  NewsError({
    required this.status,
    required this.code,
    required this.message,
  });

  factory NewsError.fromJson(Map<String, dynamic> json) => NewsError(
        status: json["status"],
        code: json["code"],
        message: json["message"],
      );
}
