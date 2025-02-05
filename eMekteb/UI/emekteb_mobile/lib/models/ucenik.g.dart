// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ucenik.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ucenik _$UcenikFromJson(Map<String, dynamic> json) => Ucenik(
      (json['id'] as num?)?.toInt(),
      json['ime'] as String?,
      json['telefon'] as String?,
      json['mail'] as String?,
      json['prezime'] as String?,
      json['username'] as String?,
      json['imeRoditelja'] as String?,
      (json['mektebId'] as num?)?.toInt(),
      json['status'] as String?,
      json['spol'] as String?,
      (json['idRazreda'] as num?)?.toInt(),
      json['datumRodjenja'] == null
          ? null
          : DateTime.parse(json['datumRodjenja'] as String),
      (json['prisustvo'] as num?)?.toDouble(),
      (json['prosjek'] as num?)?.toDouble(),
      json['nazivRazreda'] as String?,
      (json['ocjena'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UcenikToJson(Ucenik instance) => <String, dynamic>{
      'id': instance.id,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'telefon': instance.telefon,
      'mail': instance.mail,
      'username': instance.username,
      'status': instance.status,
      'spol': instance.spol,
      'datumRodjenja': instance.datumRodjenja?.toIso8601String(),
      'imeRoditelja': instance.imeRoditelja,
      'mektebId': instance.mektebId,
      'idRazreda': instance.idRazreda,
      'nazivRazreda': instance.nazivRazreda,
      'prisustvo': instance.prisustvo,
      'prosjek': instance.prosjek,
      'ocjena': instance.ocjena,
    };
