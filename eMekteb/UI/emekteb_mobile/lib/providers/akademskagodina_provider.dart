import 'package:emekteb_mobile/models/akademska_godina.dart';
import 'package:emekteb_mobile/providers/base_provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AkademskagodinaProvider extends BaseProvider<AkademskaGodina>{
  AkademskagodinaProvider() : super("AkademskaGodina");

@override
  AkademskaGodina fromJson(data) {
    // TODO: implement fromJson
    return AkademskaGodina.fromJson(data);
  }


  Future<int?> getActiveId() async {
    var url = "$baseOfUrl""AkademskaGodina/active";
    var uri = Uri.parse(url);
    var headers = getHeaders();

    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      // Assuming the data contains an 'id' field
      return data['id'] as int?;
    } else {
      throw Exception("Error with response");
    }
  }


}