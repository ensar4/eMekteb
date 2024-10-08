import 'dart:convert';
import 'dart:io';
import 'package:emekteb_mobile/models/korisnik.dart';
import 'package:flutter/cupertino.dart';
import '../models/searches/change_password_request.dart';
import '../models/searches/search_result.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';


abstract class BaseProvider<T> with ChangeNotifier{
  late String? _baseUrl;
  String _endpoint = "";

  HttpClient client = HttpClient();
  IOClient? http;

  BaseProvider(String endpoint){
    _endpoint = endpoint;
    _baseUrl = const String.fromEnvironment("baseUrl", defaultValue: "https://192.168.1.5:7160/");

    // _baseUrl = const String.fromEnvironment("baseUrl", defaultValue: "https://10.0.2.2:7160/");

    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
  }
  String get fullUrl => '$_baseUrl$_endpoint';
  String get baseOfUrl => '$_baseUrl';


  Future<SearchResult<T>> get({TextEditingController? filterController, int? page, int? pageSize, bool? sort,}) async {
    var url = "$_baseUrl$_endpoint?";

    var queryParameters = <String, dynamic>{};

    if (filterController != null && filterController.text.isNotEmpty) {
      queryParameters['FTS'] = Uri.encodeComponent(filterController.text);
    }

    if (sort != null) {
      queryParameters['IsAsc'] = sort.toString();
    }

    if (page != null) {
      queryParameters['Page'] = page.toString();
    }

    if (pageSize != null) {
      queryParameters['PageSize'] = pageSize.toString();
    }
    // Append query parameters to the URL
    url += Uri(queryParameters: queryParameters).query;

    var uri = Uri.parse(url);
    var headers = getHeaders();

    var response = await http?.get(uri, headers: headers);


    if (isValidResponse(response!)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<T>();

      result.count = data['count'];

      for (var item in data['result']) {
        result.result.add(fromJson(item));
      }

      return result;
    } else {
      throw Exception("Error with response");
    }

  }

T fromJson (data){
    throw Exception("Method not implemented");
}

  Map<String, String> getHeaders() => {
    "Content-Type": "application/json",
    "Authorization": "Bearer ${Korisnik.token ?? ""}"
  };

  bool isValidResponse(Response response) {
    if (response.statusCode < 299) {
      return true;
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception("Server error");
    }
  }

  Future<bool> delete(int? id) async {
    final url = Uri.parse('$_baseUrl$_endpoint/$id');
    final headers = getHeaders();

    final response = await http?.delete(
      url,
      headers: headers,
    );

    if (response?.statusCode == 200) {
      return true;
    } else {
      // Handle errors (optional: parse error response)
      throw Exception('Failed to delete item: ${response?.statusCode}');
    }
  }

  Future<SearchResult<T>> getById(int? id) async {
    var url = "$_baseUrl$_endpoint/getById/$id";

    var uri = Uri.parse(url);
    var headers = getHeaders();

    var response = await http?.get(uri, headers: headers);


    if (isValidResponse(response!)) {
      var data = jsonDecode(response.body);

      if (data is! Map<String, dynamic>) {
        throw Exception("Unexpected JSON format");
      }

      var result = SearchResult<T>();

      var item = fromJson(data);
      result.result.add(item);

      result.count = item != null ? 1 : 0;

      return result;
    } else {
      throw Exception("Error with response");
    }
  }

  Future<SearchResult<T>> getById2(int? id) async {
    var url = "$_baseUrl$_endpoint/$id";

    var uri = Uri.parse(url);
    var headers = getHeaders();

    var response = await http?.get(uri, headers: headers);


    if (isValidResponse(response!)) {
      var data = jsonDecode(response.body);

      if (data is! Map<String, dynamic>) {
        throw Exception("Unexpected JSON format");
      }

      var result = SearchResult<T>();

      if (data.containsKey('count') && data['count'] is int) {
        result.count = data['count'];
      } else {
        throw Exception("Invalid or missing 'count' field");
      }

      if (data.containsKey('result') && data['result'] is List) {
        for (var item in data['result']) {
          result.result.add(fromJson(item));
        }
      } else {
        throw Exception("Invalid or missing 'result' field");
      }

      return result;
    } else {
      throw Exception("Error with response");
    }
  }

  Future<void> changePassword(ChangePasswordRequest request) async {
    var url = Uri.parse("${_baseUrl}Korisnik/change-password");
    var headers = getHeaders();
    var body = jsonEncode(request.toJson());

    var response = await http?.post(url, headers: headers, body: body);


    if (response!.statusCode < 299) {
    } else if (response.statusCode == 400) {
      throw "Netačna stara lozinka";
    } else if (response.statusCode == 401) {
      throw "Unauthorized";
    } else {
      throw "Server error";
    }
  }


}