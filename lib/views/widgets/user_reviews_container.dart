import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzum_market_admin_panel/models/review_model.dart';
import 'package:uzum_market_admin_panel/service/http/review_http_service.dart';

class UserReviewsContainer extends StatefulWidget {
  final Review review;
  final int index;
  final Function(String) onReviewDeleted;

  const UserReviewsContainer({
    super.key,
    required this.review,
    required this.index,
    required this.onReviewDeleted,
  });

  @override
  State<UserReviewsContainer> createState() => _UserReviewsContainerState();
}

class _UserReviewsContainerState extends State<UserReviewsContainer> {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: widget.index == 0 ? 10.w : 0.w,
        right: 10.w,
        bottom: 5.h,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.review.userName,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text(
                          'Siz haqiqatdan ham ${widget.review.userName} tomonidan qoldirilgan sharhni ma\'lumotlar bazasidan o\'chirmoqchimisiz?',
                          style: TextStyle(fontSize: 18.sp),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.green),
                            ),
                            child: const Text(
                              'Yo\'q',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              widget.onReviewDeleted(widget.review.reviewId);
                            },
                            style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.red),
                            ),
                            child: const Text(
                              'Ha',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Text(
              widget.review.text,
              style: Theme.of(context).textTheme.bodyLarge,
              maxLines: null,
              overflow: TextOverflow.visible,
            ),
            SizedBox(height: 5.h),
            Row(
              children: List.generate(
                5,
                (starIndex) => Icon(
                  Icons.star,
                  color: starIndex < widget.review.star
                      ? Colors.yellow
                      : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}