import 'package:flutter/material.dart';
import 'package:uzum_market_admin_panel/models/review_model.dart';
import 'package:uzum_market_admin_panel/models/user_model.dart';
import 'package:uzum_market_admin_panel/views/widgets/user_reviews_container.dart';

class ShowUserContainer extends StatelessWidget {
  final int index;
  final User user;
  final List<Review> userReviews;

  const ShowUserContainer({
    super.key,
    required this.index,
    required this.user,
    required this.userReviews,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: index == 0 ? 20 : 0, bottom: 20),
      height: 250,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                            user.name,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            user.surName,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Jinsi: ${user.gender == 0 ? 'Erkak' : 'Ayol'}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Text('Tug\'ilgan sana: ${user.bornData}'),
                Text(
                  'Email: ${user.email}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: userReviews.length,
              itemBuilder: (BuildContext context, int index) =>
                  UserReviewsContainer(
                review: userReviews[index],
                index: index,
                onReviewDeleted: (p0) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
