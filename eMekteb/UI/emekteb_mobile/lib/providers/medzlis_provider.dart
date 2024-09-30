import 'package:emekteb_mobile/models/medzlis.dart';
import 'package:emekteb_mobile/providers/base_provider.dart';

class MedzlisProvider extends BaseProvider<Medzlis>{
  MedzlisProvider() : super("Medzlis");

@override
Medzlis fromJson(data) {
    // TODO: implement fromJson
    return Medzlis.fromJson(data);
  }
}