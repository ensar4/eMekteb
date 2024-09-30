import 'package:emekteb_mobile/models/ocjene.dart';
import 'package:emekteb_mobile/providers/base_provider.dart';

class OcjeneProvider extends BaseProvider<Ocjene>{
  OcjeneProvider() : super("Ocjene");

@override
Ocjene fromJson(data) {
    // TODO: implement fromJson
    return Ocjene.fromJson(data);
  }





}