import 'package:uzum_market_admin_panel/models/review_model.dart';
import 'package:uzum_market_admin_panel/service/http/review_http_service.dart';

class ReviewViewModel {
  final ReviewHttpService _reviewHttpService = ReviewHttpService();

  Future<List<Review>> getReviews() async {
    try {
      return await _reviewHttpService.getReviews();
    } catch (e) {
      print('error: ReviewViewModel().getReviews(): $e');
      rethrow;
    }
  }

  Future<void> deleteReview({required String id}) async {
    try {
      await _reviewHttpService.deleteReview(id: id);
    } catch (e) {
      rethrow;
    }
  }
}
