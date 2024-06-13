import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uzum_market_admin_panel/models/review_model.dart';

class ReviewHttpService {
  final Uri _url = Uri.parse(
    'https://to-do-f5021-default-rtdb.firebaseio.com/review.json',
  );

  Future<List<Review>> getReviews() async {
    try {
      final response = await http.get(_url);
      if (response.statusCode == 200) {
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
      print('error: ReviewHttpService().loadedReviews(): $e');
      rethrow;
    }
  }

  Future<void> addReview() async {
    final response = await http.post(
      _url,
      body: jsonEncode(
        {
          'product-id': '-O-BHB-5Slg_-Y1q0JcX',
          'user-name': 'gishmat',
          'text': 'awesome',
          'star': 2,
          'published-date-time': '3245t6789',
        },
      ),
    );
    print(response.body);
  }
}
