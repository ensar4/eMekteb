import 'package:emekteb_mobile/models/mekteb.dart';
import 'package:emekteb_mobile/providers/base_provider.dart';


class MektebProvider extends BaseProvider<Mekteb>{
  MektebProvider() : super("Mekteb");

@override
  Mekteb fromJson(data) {
    // TODO: implement fromJson
    return Mekteb.fromJson(data);
  }

}