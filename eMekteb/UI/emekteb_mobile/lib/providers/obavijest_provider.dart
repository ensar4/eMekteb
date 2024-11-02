import 'dart:convert';
import 'package:emekteb_mobile/models/obavijest.dart';
import 'package:emekteb_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class ObavijestProvider extends BaseProvider<Obavijest>{
  ObavijestProvider() : super("Obavijest");

@override
Obavijest fromJson(data) {
    // TODO: implement fromJson
    return Obavijest.fromJson(data);
  }

  Future<bool> insert(String naslov, String opis, DateTime datumObjave, int? mektebId) async {
    final url = Uri.parse(fullUrl);
    final headers = getHeaders();

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode({
        'naslov': naslov,
        'opis': opis,
        'datumObjave': datumObjave.toIso8601String(),
        'vrstaObjave': 'Obavijest',
        'mektebId': mektebId,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> update(int? id, String opis, DateTime datumObjave, String naslov) async {
    final url = Uri.parse('$baseOfUrl''Obavijest/$id');
    final headers = getHeaders();

    final response = await http.put(
      url,
      headers: headers,
      body: json.encode({
        'naslov': naslov,
        'opis': opis,
        'datumObjave': datumObjave.toIso8601String(),
        'vrstaObjave':'obavijest',
      }),
    );

    if (response.statusCode == 200) {
      return true;
    }
    else if (response.statusCode == 400){
      throw "Nije moguće editovati aktivnu obavijest!";
      }
    else {
      throw "Došlo je do greške pri ažuriranju obavijesti.";
    }
  }

  Future<bool> activateObavijest(int? obavijestId) async {
    final url = Uri.parse('$baseOfUrl''Obavijest/$obavijestId/activate');
    final headers = getHeaders();

    final response = await http.put(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {

      return true;
    } else {
      throw Exception('Failed to activate obavijest');
    }
  }

  Future<bool> hideObavijest(int? obavijestId) async {
    final url = Uri.parse('$baseOfUrl''Obavijest/$obavijestId/hide');
    final headers = getHeaders();

    final response = await http.put(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to hide obavijest');
    }
  }



}