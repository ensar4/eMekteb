import 'dart:convert';
import 'package:emekteb_admin/models/takmicenje.dart';
import 'package:emekteb_admin/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class TakmicenjaProvider extends BaseProvider<Takmicenje>{
  TakmicenjaProvider() : super("Takmicenje");

@override
  Takmicenje fromJson(data) {
    // TODO: implement fromJson
    return Takmicenje.fromJson(data);
  }

  Future<bool> createTakmicenje(String godina, DateTime datumOdrzavanja, String lokacija, String vrijemePocetka, String info) async {
    final url = Uri.parse(fullUrl);
    var headers = getHeaders();

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode({
        'godina': godina,
        'datumOdrzavanja': datumOdrzavanja.toIso8601String(),
        'lokacija': lokacija,
        'vrijemePocetka': vrijemePocetka,
        'info': info,
        'medzlisId': 1,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }



}