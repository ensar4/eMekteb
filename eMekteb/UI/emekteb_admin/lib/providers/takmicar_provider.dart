import 'dart:convert';
import 'package:emekteb_admin/models/takmicar.dart';
import 'package:http/http.dart' as http;
import 'base_provider.dart';

class TakmicarProvider extends BaseProvider<Takmicar> {
  TakmicarProvider() : super("Takmicar");

  @override
  Takmicar fromJson(data) {
    return Takmicar.fromJson(data);
  }

  Future<bool> addOcjena(int? takmicarId, int ocjena) async {
    final url = Uri.parse('$baseOfUrl''Takmicar/$takmicarId/points');

    var headers = getHeaders();

    final body = json.encode(ocjena);

    try {
      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }


  Future<bool> deleteTakmicar(int? id) async {
    final url = Uri.parse('$baseOfUrl''Takmicar/$id');
    var headers = getHeaders();

    final response = await http.delete(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete item: ${response.statusCode}');
    }
  }

}
