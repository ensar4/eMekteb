import 'package:emekteb_mobile/models/searches/change_password_request.dart';
import 'base_provider.dart';

class PasswordProvider extends BaseProvider<ChangePasswordRequest> {
  PasswordProvider() : super("Korisnik");

  @override
  ChangePasswordRequest fromJson(data) {
    return ChangePasswordRequest.fromJson(data);
  }


}

