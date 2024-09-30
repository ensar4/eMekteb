import 'dart:convert';
import 'package:emekteb_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import '../models/slika.dart';

class SlikaProvider extends BaseProvider<Slika>{
  SlikaProvider() : super("Slika");

@override
Slika fromJson(data) {
    // TODO: implement fromJson
    return Slika.fromJson(data);
  }

  Future<bool> insert(String slikaBytes, int? korisnikId) async {
    final url = Uri.parse(fullUrl);
    final headers = getHeaders();

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode({
        'slikaBytes': slikaBytes,
        'korisnikId': korisnikId,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> update(
      int? id,
      String slikaBytes,
      int? korisnikId
      ) async {
    final url = Uri.parse('$baseOfUrl''Slika/$id');
    final headers = getHeaders();

    final response = await http.put(
      url,
      headers: headers,
      body: json.encode({
        'slikaBytes': slikaBytes,
        'korisnikId': korisnikId,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

}