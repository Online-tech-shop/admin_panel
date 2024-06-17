import 'package:flutter/material.dart';
import 'package:uzum_market_admin_panel/models/review_model.dart';
import 'package:uzum_market_admin_panel/models/user_model.dart';
import 'package:uzum_market_admin_panel/viewmodel/review_view_model.dart';
import 'package:uzum_market_admin_panel/viewmodel/user_view_model.dart';
import 'package:uzum_market_admin_panel/views/widgets/show_user_container.dart';

class ManageUserScreen extends StatefulWidget {
  const ManageUserScreen({super.key});

  @override
  State<ManageUserScreen> createState() => _ManageUserScreenState();
}

class _ManageUserScreenState extends State<ManageUserScreen> {
  final UserViewModel _userViewModel = UserViewModel();

  final ReviewViewModel _reviewViewModel = ReviewViewModel();
  List<User> _usersList = [];
  List<Review> _reviewsList = [];
  bool isDataCame = false;

  Future<void> getData() async {
    _usersList = await _userViewModel.getUsers();
    _reviewsList = await _reviewViewModel.getReviews();
  }

  @override
  void initState() {
    super.initState();
    getData().then((_) => setState(() => isDataCame = true));
  }

  void onUserDeleted(String p0) async {
    _userViewModel.deleteUser(p0);
    _usersList.removeAt(_usersList.indexWhere((element) => element.id == p0));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Foydalanuvchi muvaffaqiyatli o\'chirildi!'),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return isDataCame
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              itemCount: _usersList.length,
              itemBuilder: (BuildContext context, int index) =>
                  ShowUserContainer(
                index: index,
                user: _usersList[index],
                userReviews: _usersList[index].getUserReviews(_reviewsList),
                onUserDeleted: onUserDeleted,
              ),
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
