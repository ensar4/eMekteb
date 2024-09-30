import 'dart:convert';
import 'package:emekteb_mobile/models/takmicar.dart';
import 'package:emekteb_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class TakmicarProvider extends BaseProvider<Takmicar>{
  TakmicarProvider() : super("Takmicar");

@override
Takmicar fromJson(data) {
    // TODO: implement fromJson
    return Takmicar.fromJson(data);
  }

  Future<bool> insert(String ime, DateTime datumRodjenja, String prezime, int? kategorijaId) async {
    final url = Uri.parse(fullUrl);
    final headers = getHeaders();

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode({
        'ime': ime,
        'prezime': prezime,
        'datumRodjenja': datumRodjenja.toIso8601String(),
        'kategorijaId': kategorijaId,
        'ukupnoBodova': '0',
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

}