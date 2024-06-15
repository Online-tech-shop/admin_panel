import 'package:flutter/material.dart';
import 'package:uzum_market_admin_panel/models/review_model.dart';
import 'package:uzum_market_admin_panel/models/user_model.dart';
import 'package:uzum_market_admin_panel/viewmodel/review_view_model.dart';
import 'package:uzum_market_admin_panel/views/widgets/user_reviews_container.dart';

class ShowUserContainer extends StatefulWidget {
  final int index;
  final User user;
  final List<Review> userReviews;
  final Function(String) onUserDeleted;

  const ShowUserContainer({
    super.key,
    required this.index,
    required this.user,
    required this.userReviews,
    required this.onUserDeleted,
  });

  @override
  State<ShowUserContainer> createState() => _ShowUserContainerState();
}

class _ShowUserContainerState extends State<ShowUserContainer> {
  final ReviewViewModel _reviewViewModel = ReviewViewModel();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: widget.index == 0 ? 20 : 0, bottom: 20),
      height: widget.userReviews.isNotEmpty ? 250 : 150,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              bottom: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Text(
                            widget.user.name,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            widget.user.surName,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Jinsi: ${widget.user.gender == 0 ? 'Erkak' : 'Ayol'}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tug\'ilgan sana: ${widget.user.bornData}'),
                        Text(
                          'Email: ${widget.user.email}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text(
                              'Siz haqiqatdan ham ${widget.user.name}ni ma\'lumotlar bazasidan o\'chirmoqchimisiz?',
                              style: const TextStyle(fontSize: 18),
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
                                  widget.onUserDeleted(widget.user.id);
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
                      child: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (widget.userReviews.isNotEmpty)
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.userReviews.length,
                itemBuilder: (BuildContext context, int index) =>
                    UserReviewsContainer(
                  review: widget.userReviews[index],
                  index: index,
                  onReviewDeleted: (p0) {
                    _reviewViewModel.deleteReview(id: p0);
                    int? a = widget.userReviews
                        .indexWhere((element) => element.reviewId == p0);
                    widget.userReviews.removeAt(a);
                    setState(() {});
                  },
                ),
              ),
            )
          else
            const Expanded(
              child: Center(child: Text('Sharh qoldirilmagan')),
            ),
        ],
      ),
    );
  }
}
