import 'review_model.dart';

class User {
  final String id;
  final String name;
  final String surName;
  final int gender;
  final String bornData;
  final String email;

  const User({
    required this.id,
    required this.name,
    required this.surName,
    required this.gender,
    required this.bornData,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      surName: json['sur-name'] as String,
      gender: json['gender'] as int,
      bornData: json['born-data'] as String,
      email: json['email'] as String,
    );
  }

  List<Review> getUserReviews(List<Review> reviews) =>
      reviews.where((Review review) => review.userId == id).toList();
}
