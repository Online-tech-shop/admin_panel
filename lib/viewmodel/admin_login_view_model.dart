import 'package:uzum_market_admin_panel/service/http/admin_login_http_service.dart';

class AdminLoginViewModel {
  final AdminLoginHttpService _adminLoginHttpService = AdminLoginHttpService();

  Future<void> loginAdmin({
    required String email,
    required String password,
  }) async {
    try {
      await _adminLoginHttpService.login(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> registerNewAdmin({
    required String email,
    required String password,
  }) async {
    try {
      await _adminLoginHttpService.register(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }
}
