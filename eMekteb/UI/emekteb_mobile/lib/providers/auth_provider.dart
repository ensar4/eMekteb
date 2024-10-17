import 'dart:convert';
import 'package:emekteb_mobile/models/korisnik.dart';
import 'package:flutter/cupertino.dart';
import '../models/constants/claim_type.dart';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

class AuthProvider with ChangeNotifier{
   static String? _baseUrl;
   HttpClient client = HttpClient(); //here was ... = new HttpClient();
   IOClient? http;


  AuthProvider(){
   //_baseUrl = const String.fromEnvironment("IdentityServerUrl", defaultValue: "https://192.168.1.5:7049/");
    _baseUrl = const String.fromEnvironment("IdentityServerUrl", defaultValue: "https://10.0.2.2:7049/");
    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
  }

   Future<String?> login(String username, String lozinka) async {
     var uri = Uri.parse("${_baseUrl}Login?username=$username&lozinka=$lozinka");

     var response = await http?.get(uri);

     if (response != null && _isValidResponse(response)) {
       return response.body;
     } else {
       throw Exception("Response is not valid");
     }
   }
   void getUser(String token) {
     final decodedToken = _decode(token);

     Korisnik.id = int.parse(decodedToken[ClaimType.sid] as String);
     Korisnik.ime = decodedToken[ClaimType.name] as String?;
     Korisnik.username = decodedToken[ClaimType.nameIdentifier] as String?;
     //Korisnik.mektebId = decodedToken[ClaimType.mektebId] as int?;
     Korisnik.token = token;

     var role = decodedToken[ClaimType.role];
     if (role is List<dynamic>) {
       Korisnik.uloge = List<String>.from(decodedToken[ClaimType.role]);
     } else if (role != null) {
       Korisnik.uloge.add(role);
     }

   }

   bool _isValidResponse(Response response) {
     if (response.statusCode < 299) {
       return true;
     } else if (response.statusCode == 500) {
       throw "Nepostojeće korisničko ime.";
     } else if (response.statusCode == 404) {
       throw "Neispravni kredencijali za prijavu.";
     } else if (response.statusCode == 400) {
       throw "Unesite lozinku!";
     } else {
       throw "Pokušajte ponovo.";
     }
   }

   Map<String, dynamic> _decode(String token) {
     final splitToken = token.split(".");
     if (splitToken.length != 3) {
       throw const FormatException('Invalid token');
     }
     try {
       final payloadBase64 = splitToken[1];
       final normalizedPayload = base64.normalize(payloadBase64);
       final payloadString = utf8.decode(base64.decode(normalizedPayload));
       final decodedPayload = jsonDecode(payloadString) as Map<String, dynamic>;

       return decodedPayload;
     } catch (error) {
       throw const FormatException('Invalid payload');
     }
   }



}
