import 'package:emekteb_mobile/providers/base_provider.dart';
import '../models/admin.dart';

class AdminProvider extends BaseProvider<Admin>{
  AdminProvider() : super("Admin");

@override
Admin fromJson(data) {
    // TODO: implement fromJson
    return Admin.fromJson(data);
  }
}