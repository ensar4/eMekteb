import 'dart:convert';

import 'package:emekteb_admin/models/medzlis.dart';
import 'package:emekteb_admin/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class MedzlisProvider extends BaseProvider<Medzlis>{
  MedzlisProvider() : super("Medzlis");

@override
Medzlis fromJson(data) {
    // TODO: implement fromJson
    return Medzlis.fromJson(data);
  }

  Future<int?> insert(String naziv, String adresa, String telefon, String mail, int? muftijstvoId) async {
    final url = Uri.parse(fullUrl);
    var headers = getHeaders();

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode({
        'naziv': naziv,
        'adresa': adresa,
        'telefon':telefon,
        'mail':mail,
        'muftijstvoId': muftijstvoId,
      }),
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['id'];
    } else {
      return null;
    }
  }


  Future<bool> update(
      int? id,
      String naziv,
      String telefon,
      String adresa,
      String mail,
      ) async {
    final url = Uri.parse('$baseOfUrl''Medzlis/$id');
    final headers = getHeaders();

    final response = await http.put(
      url,
      headers: headers,
      body: json.encode({
        'naziv': naziv,
        'telefon': telefon,
        'adresa': adresa,
        'mail': mail,
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