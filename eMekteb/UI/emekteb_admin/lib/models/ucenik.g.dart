// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ucenik.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ucenik _$UcenikFromJson(Map<String, dynamic> json) => Ucenik(
      json['id'] as int?,
      json['ime'] as String?,
      json['telefon'] as String?,
      json['prezime'] as String?,
      json['imeRoditelja'] as String?,
      json['mektebId'] as int?,
      json['status'] as String?,
      json['razredId'] as int?,
      json['datumRodjenja'] == null
          ? null
          : DateTime.parse(json['datumRodjenja'] as String),
      (json['prisustvo'] as num?)?.toDouble(),
      (json['prosjek'] as num?)?.toDouble(),
      json['nazivRazreda'] as String?,
    );

Map<String, dynamic> _$UcenikToJson(Ucenik instance) => <String, dynamic>{
      'id': instance.id,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'telefon': instance.telefon,
      'status': instance.status,
      'datumRodjenja': instance.datumRodjenja?.toIso8601String(),
      'imeRoditelja': instance.imeRoditelja,
      'nazivRazreda': instance.nazivRazreda,
      'mektebId': instance.mektebId,
      'razredId': instance.razredId,
      'prisustvo': instance.prisustvo,
      'prosjek': instance.prosjek,
    };
