import 'dart:convert';
import 'package:emekteb_mobile/models/kamp.dart';
import 'package:emekteb_mobile/providers/base_provider.dart';
import '../models/searches/search_result.dart';

class KampProvider extends BaseProvider<Kamp>{
  KampProvider() : super("Kamp");


@override
  Kamp fromJson(data) {
    // TODO: implement fromJson
    return Kamp.fromJson(data);
  }

 Future<bool> insertKamp(String opis, DateTime datumPocetka, DateTime datumZavrsetka, String naziv, int? mektebId) async {
   final url = Uri.parse(fullUrl);
   final headers = getHeaders();

   final response = await http?.post(
     url,
     headers: headers,
     body: json.encode({
       'opis': opis,
       'datumPocetka': datumPocetka.toIso8601String(),
       'datumZavrsetka': datumZavrsetka.toIso8601String(),
       'naziv': naziv,
       'voditelj':'',
       'mektebId': mektebId,
     }),
   );

   if (response?.statusCode == 200) {
     //await fetchData(); // Refresh data
     return true;
   } else {
     return false;
   }
 }


  Future<SearchResult<Kamp>> getLastTakmicenje() async {
    var url = "$baseOfUrl""Kamp/last";
    var uri = Uri.parse(url);
    var headers = getHeaders();

    var response = await http?.get(uri, headers: headers);

    if (isValidResponse(response!)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<Kamp>();

      result.count = 1;
      result.result.add(fromJson(data));

      return result;
    } else {
      throw Exception("Error with response");
    }
  }


}