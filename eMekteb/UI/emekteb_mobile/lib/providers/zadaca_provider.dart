import 'dart:convert';
import 'package:emekteb_mobile/models/zadaca.dart';
import 'package:emekteb_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class ZadacaProvider extends BaseProvider<Zadaca>{
  ZadacaProvider() : super("Zadaca");


@override
Zadaca fromJson(data) {
    // TODO: implement fromJson
    return Zadaca.fromJson(data);
  }

  Future<bool> insert(DateTime datumDodjele, String lekcija, int? korisnikId, int? ocjeneId, int? razredId, String zadaca) async {
    final url = Uri.parse(fullUrl);
    final headers = getHeaders();

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode({
        'datumDodjele': datumDodjele.toIso8601String(),
        'korisnikId': korisnikId,
        'ocjeneId': ocjeneId,
        'lekcija': lekcija,
        'razredId': razredId,
        'zaZadacu': zadaca
      }),
    );

    if (response.statusCode == 200 ||response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}