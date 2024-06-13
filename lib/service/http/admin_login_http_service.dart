// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// class AdminLoginHttpService {
//   final String _apiKey = 'AIzaSyClOZuEggHN1fxUh0yqNTTJ6Nz_HtvGtX0';
//
//   Future<void> _authenticate({
//     required String email,
//     required String password,
//     required String query,
//   }) async {
//     Uri url = Uri.parse(
//       'https://identitytoolkit.googleapis.com/v1/accounts:$query?key=$_apiKey',
//     );
//
//     try {
//       final http.Response response = await http.post(
//         url,
//         body: jsonEncode(
//           {
//             'email': email,
//             'password': password,
//             'returnSecureToken': false,
//           },
//         ),
//       );
//       print(response.body);
//       final data = jsonDecode(response.body);
//       if (response.statusCode != 200) {
//         throw (data['error']['message']);
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<void> register(
//       {required String email, required String password}) async {
//     await _authenticate(
//       email: email,
//       password: password,
//       query: 'signUp',
//     );
//   }
//
//   Future<void> login({required String email, required String password}) async {
//     await _authenticate(
//       email: email,
//       password: password,
//       query: 'signInWithPassword',
//     );
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

class AdminLoginHttpService {
  final String _apiKey = 'AIzaSyClOZuEggHN1fxUh0yqNTTJ6Nz_HtvGtX0';

  Future<Map<String, dynamic>> _authenticate({
    required String email,
    required String password,
    required String query,
  }) async {
    Uri url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:$query?key=$_apiKey',
    );

    try {
      final http.Response response = await http.post(
        url,
        body: jsonEncode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        throw Exception(data['error']['message']);
      }
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register(
      {required String email, required String password}) async {
    await _authenticate(
      email: email,
      password: password,
      query: 'signUp',
    );
  }

  Future<void> login({required String email, required String password}) async {
    await _authenticate(
      email: email,
      password: password,
      query: 'signInWithPassword',
    );
  }
}
