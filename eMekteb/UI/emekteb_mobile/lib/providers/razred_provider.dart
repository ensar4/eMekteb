import 'package:emekteb_mobile/providers/base_provider.dart';
import '../models/razred.dart';

class RazredProvider extends BaseProvider<Razred>{
  RazredProvider() : super("Razred");

@override
Razred fromJson(data) {
    // TODO: implement fromJson
    return Razred.fromJson(data);
  }
}