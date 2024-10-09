// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      (json['id'] as num?)?.toInt(),
      json['ime'] as String,
      json['telefon'] as String?,
      json['prezime'] as String,
      (json['mektebId'] as num?)?.toInt(),
      json['status'] as String?,
      json['datumRodjenja'] == null
          ? null
          : DateTime.parse(json['datumRodjenja'] as String),
      json['username'] as String?,
      json['imeRoditelja'] as String?,
      json['mail'] as String?,
      json['spol'] as String?,
      (json['razredId'] as num?)?.toInt(),
      json['nazivRazreda'] as String?,
      (json['prosjek'] as num?)?.toDouble(),
      (json['prisustvo'] as num?)?.toDouble(),
      (json['idRazreda'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'username': instance.username,
      'telefon': instance.telefon,
      'mail': instance.mail,
      'spol': instance.spol,
      'status': instance.status,
      'datumRodjenja': instance.datumRodjenja?.toIso8601String(),
      'imeRoditelja': instance.imeRoditelja,
      'mektebId': instance.mektebId,
      'razredId': instance.razredId,
      'nazivRazreda': instance.nazivRazreda,
      'prisustvo': instance.prisustvo,
      'prosjek': instance.prosjek,
      'idRazreda': instance.idRazreda,
    };
