class Review {
  final String reviewId;
  final String userId;
  final String productId;
  final String userName;
  final String text;
  final int star;
  final String publishedDateTime;

  const Review({
    required this.reviewId,
    required this.userId,
    required this.productId,
    required this.userName,
    required this.text,
    required this.star,
    required this.publishedDateTime,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      reviewId: json['review-id'] as String,
      userId: json['user-id'] as String,
      productId: json['product-id'] as String,
      userName: json['user-name'] as String,
      text: json['text'] as String,
      star: json['star'] as int,
      publishedDateTime: json['published-date-time'] as String,
    );
  }
}
