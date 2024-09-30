import 'package:emekteb_admin/models/medzlis.dart';
import 'package:emekteb_admin/providers/base_provider.dart';

class MedzlisProvider extends BaseProvider<Medzlis>{
  MedzlisProvider() : super("Medzlis");

@override
Medzlis fromJson(data) {
    // TODO: implement fromJson
    return Medzlis.fromJson(data);
  }
}