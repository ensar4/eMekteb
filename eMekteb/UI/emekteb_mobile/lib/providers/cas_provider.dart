import 'dart:convert';
import 'package:emekteb_mobile/models/cas.dart';
import 'package:emekteb_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class CasProvider extends BaseProvider<Cas>{
  CasProvider() : super("Cas");

@override
  Cas fromJson(data) {
    // TODO: implement fromJson
    return Cas.fromJson(data);
  }

  Future<bool> insert(String lekcija, DateTime datum, String razred, int? mektebId, int? akademskaGodinaId) async {
    final url = Uri.parse(fullUrl);
    final headers = getHeaders();

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode({
        'datum': datum.toIso8601String(),
        'razred': razred,
        'lekcija': lekcija,
        'mektebId': mektebId,
        'akademskaGodinaId':akademskaGodinaId
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }



}