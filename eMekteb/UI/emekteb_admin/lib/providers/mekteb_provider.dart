import 'dart:convert';
import 'package:emekteb_admin/models/mekteb.dart';
import 'package:emekteb_admin/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class MektebProvider extends BaseProvider<Mekteb>{
  MektebProvider() : super("Mekteb");


@override
  Mekteb fromJson(data) {
    // TODO: implement fromJson
    return Mekteb.fromJson(data);
  }

  Future<int?> insert(String naziv, String telefon, String adresa) async {
    final url = Uri.parse(fullUrl);
    var headers = getHeaders();

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode({
        'naziv': naziv,
        'telefon':telefon,
        'medzlisId': 1,
        'adresa': adresa,
        'akademskaGodinaId': 1,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['id'];
    } else {
      return null;
    }
  }
}