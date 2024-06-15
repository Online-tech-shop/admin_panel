import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:uzum_market_admin_panel/models/review_model.dart';
import 'package:uzum_market_admin_panel/models/user_model.dart';
import 'package:uzum_market_admin_panel/viewmodel/review_view_model.dart';
import 'package:uzum_market_admin_panel/viewmodel/user_view_model.dart';
import 'package:uzum_market_admin_panel/views/widgets/show_user_container.dart';

class ManageUserScreen extends StatelessWidget {
  ManageUserScreen({super.key});

  final UserViewModel _userViewModel = UserViewModel();
  final ReviewViewModel _reviewViewModel = ReviewViewModel();

  Future<Map<String, dynamic>> getData() async {
    return {
      'user': await _userViewModel.getUsers(),
      'review': await _reviewViewModel.getReviews(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.hasError) {
          return Center(
            child: Text(
              'error: snapshot ${snapshot.error}',
            ),
          );
        } else {
          List<User> usersList = snapshot.data['user'];
          List<Review> usersReviewList = snapshot.data['review'];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              itemCount: usersList.length,
              itemBuilder: (BuildContext context, int index) => ShowUserContainer(
                index: index,
                user: usersList[index],
                userReviews: usersList[index].getUserReviews(usersReviewList),
              ),
            ),
          );
        }
      },
    );
  }
}
