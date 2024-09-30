import 'dart:convert';
import 'package:emekteb_mobile/models/takmicenje.dart';
import 'package:emekteb_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import '../models/searches/search_result.dart';

class TakmicenjaProvider extends BaseProvider<Takmicenje>{
  TakmicenjaProvider() : super("Takmicenje");

@override
  Takmicenje fromJson(data) {
    // TODO: implement fromJson
    return Takmicenje.fromJson(data);
  }

  Future<SearchResult<Takmicenje>> getLastTakmicenje() async {
    var url = "$baseOfUrl""Takmicenje/last";
    var uri = Uri.parse(url);
    var headers = getHeaders();

    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<Takmicenje>();

      result.count = 1; // Since we're expecting only one result
      result.result.add(fromJson(data));

      return result;
    } else {
      throw Exception("Error with response");
    }
  }


}