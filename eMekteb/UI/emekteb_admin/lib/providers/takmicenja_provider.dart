import 'dart:convert';
import 'package:emekteb_admin/models/korisnik.dart';
import 'package:emekteb_admin/models/mekteb_bodovi_dto.dart';
import 'package:emekteb_admin/models/takmicenje.dart';
import 'package:emekteb_admin/providers/base_provider.dart';
import 'package:http/http.dart' as http;

import '../models/searches/search_result.dart';

class TakmicenjaProvider extends BaseProvider<Takmicenje>{
  TakmicenjaProvider() : super("Takmicenje");


@override
  Takmicenje fromJson(data) {
    // TODO: implement fromJson
    return Takmicenje.fromJson(data);
  }

  Future<bool> createTakmicenje(String godina, DateTime datumOdrzavanja, String lokacija, String vrijemePocetka, String info, int? medzlisId) async {
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
        'medzlisId': medzlisId,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<SearchResult<MektebBodoviDto>> getBodoviPoMektebu(int? takmicenjeId) async {
    final url = Uri.parse('$fullUrl/$takmicenjeId/bodovi-po-mektebu');
    final headers = getHeaders();

    final response = await http.get(url, headers: headers);

    if (isValidResponse(response)) {
      final data = jsonDecode(response.body);

      if (data is! Map<String, dynamic>) {
        throw Exception("Unexpected JSON format");
      }

      final result = SearchResult<MektebBodoviDto>();

      if (data.containsKey('count') && data['count'] is int) {
        result.count = data['count'];
      } else {
        throw Exception("Invalid or missing 'count' field");
      }

      if (data.containsKey('result') && data['result'] is List) {
        for (var item in data['result']) {
          result.result.add(MektebBodoviDto.fromJson(item));
        }
      } else {
        throw Exception("Invalid or missing 'result' field");
      }

      return result;
    } else {
      throw Exception("Error with response: ${response.statusCode}");
    }
  }
  Future<bool> update(
      int? id,
      String? godina,
      DateTime? datumOdrzavanja,
      String? lokacija,
      String? vrijemePocetka,
      String? info
      ) async {
    final url = Uri.parse('$baseOfUrl''Takmicenje/$id');
    final headers = getHeaders();
    final response = await http.put(
      url,
      headers: headers,
      body: json.encode({
        'godina': godina,
        'datumOdrzavanja': datumOdrzavanja?.toIso8601String(),
        'lokacija': lokacija,
        'vrijemePocetka': vrijemePocetka,
        'info': info,
      }),

    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 405){
      throw Exception('Failed: ${response.statusCode}');
    }
    return false;
  }


}