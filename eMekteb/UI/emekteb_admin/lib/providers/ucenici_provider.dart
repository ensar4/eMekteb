import 'package:emekteb_admin/models/ucenik.dart';
import 'package:emekteb_admin/providers/base_provider.dart';

class UceniciProvider extends BaseProvider<Ucenik>{
  UceniciProvider() : super("Ucenici");

@override
Ucenik fromJson(data) {
    // TODO: implement fromJson
    return Ucenik.fromJson(data);
  }


}