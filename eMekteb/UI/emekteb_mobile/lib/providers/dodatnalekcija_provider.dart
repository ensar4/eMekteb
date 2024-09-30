import 'dart:convert';
import 'package:emekteb_mobile/models/dodatna_lekcija.dart';
import 'package:http/http.dart' as http;
import 'base_provider.dart';

class DodatnaLekcijaProvider extends BaseProvider<DodatnaLekcija> {
  DodatnaLekcijaProvider() : super("DodatneLekcije");

  @override
  DodatnaLekcija fromJson(data) {
    return DodatnaLekcija.fromJson(data);
  }

  Future<bool> insertLekcija(String tekst, DateTime datumObjavljivanja, String naziv, int? mektebId) async {
    final url = Uri.parse(fullUrl);
    final headers = getHeaders();

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode({
        'naziv': naziv,
        'tekst': tekst,
        'datumObjavljivanja': datumObjavljivanja.toIso8601String(),
        'likes': 0,
        'dislikes': 0,
        'mektebId': mektebId,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addLike(int? lekcijaId, int like) async {
    final url = Uri.parse('$fullUrl/$lekcijaId/likes');
    final headers = getHeaders();

    final body = json.encode(like);

    try {
      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to update like: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error updating like: $e');
      return false;
    }
  }

  Future<bool> addDislike(int? lekcijaId, int dislike) async {
    final url = Uri.parse('$fullUrl/$lekcijaId/dislikes');
    final headers = getHeaders();

    final body = json.encode(dislike);

    try {
      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to update dislike: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error updating dislike: $e');
      return false;
    }
  }
}
