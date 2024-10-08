import 'dart:convert';
import 'package:emekteb_admin/models/razred.dart';
import 'package:emekteb_admin/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class RazredProvider extends BaseProvider<Razred>{
  RazredProvider() : super("Razred");

@override
Razred fromJson(data) {
    // TODO: implement fromJson
    return Razred.fromJson(data);
  }

  Future<bool> insertRazred(String naziv, int? mektebId) async {
    final url = Uri.parse(fullUrl);
    var headers = getHeaders();

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode({
        'naziv': naziv,
        'mektebId': mektebId,
      }),
    );

    if (response.statusCode == 200) {
      print(url);
      return true;
    } else {
      return false;
    }
  }



}