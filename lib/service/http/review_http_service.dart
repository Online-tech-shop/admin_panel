import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uzum_market_admin_panel/models/review_model.dart';

class ReviewHttpService {
  final Uri _url = Uri.parse(
    'https://to-do-f5021-default-rtdb.firebaseio.com/review.json',
  );

  Future<List<Review>> getReviews() async {
    try {
      final http.Response response = await http.get(_url);
      if (response.statusCode == 200) {
        if (response.body == 'null') {
          return [];
        }
        final Map<String, dynamic> data = jsonDecode(response.body);

        List<Review> loadedReviews = [];

        data.forEach(
          (String key, dynamic value) {
            value['review-id'] = key;
            loadedReviews.add(Review.fromJson(value));
          },
        );

        return loadedReviews;
      }
      throw 'error: ReviewHttpService().loadedReviews()';
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteReview({required String id}) async {
    try {
      await http.delete(
        Uri.parse(
          'https://to-do-f5021-default-rtdb.firebaseio.com/review/$id.json',
        ),
      );
    } catch (e) {
      debugPrint('error: ReviewHttpService().deleteReview(): $e');
      rethrow;
    }
  }
}
