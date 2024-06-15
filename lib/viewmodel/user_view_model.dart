import 'package:uzum_market_admin_panel/models/user_model.dart';
import 'package:uzum_market_admin_panel/service/http/user_http_service.dart';

class UserViewModel {
  final UserHttpService _userHttpService = UserHttpService();

  Future<List<User>> getUsers() async {
    try {
      return await _userHttpService.getUsers();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUser(String id) async{
    try{
      await _userHttpService.deleteReview(id);
    }catch(e){
      rethrow;
    }
  }

}
