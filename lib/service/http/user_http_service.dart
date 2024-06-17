import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uzum_market_admin_panel/models/user_model.dart';

class UserHttpService {
  final Uri _url =
      Uri.parse('https://to-do-f5021-default-rtdb.firebaseio.com/users.json');

  Future<List<User>> getUsers() async {
    try {
      final response = await http.get(_url);
      if (response.statusCode == 200) {
        if (response.body == 'null') {
          return [];
        }
        final Map<String, dynamic> data = jsonDecode(response.body);
        List<User> loadedUsers = [];
        data.forEach(
          (key, value) {
            value['id'] = key;
            loadedUsers.add(User.fromJson(value));
          },
        );

        return loadedUsers;
      }
      throw 'error: UserHttpService().getUsers()';
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> addUser() async {
  //   await http.post(
  //     _url,
  //     body: jsonEncode(
  //       {
  //         'name': 'Gishmatali',
  //         'sur-name': 'userjon',
  //         'gender': 1,
  //         'born-data': 'yesterday',
  //         'email': 'email',
  //       },
  //     ),
  //   );
  // }

  Future<void> deleteReview(String id) async {
    final Uri url = Uri.parse(
      'https://to-do-f5021-default-rtdb.firebaseio.com/users/$id.json',
    );
    await http.delete(url);
  }
}
