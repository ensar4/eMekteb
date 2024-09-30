class Korisnik{
  static int? id;
  static String? ime;
  static String? prezime;
  static String? username;
  static String? telefon;
  static String? mail;
  static String? spol;
  static String? status;
  static DateTime? datumRodjenja;
  static String? imeRoditelja;
  static int? mektebId;
  static int? razredId;
  static String? token;
  static List<String> uloge=[];


  static void reset() {
    uloge = [];
  }
}