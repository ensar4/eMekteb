// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'takmicar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Takmicar _$TakmicarFromJson(Map<String, dynamic> json) => Takmicar(
      json['id'] as int?,
      json['ime'] as String?,
      json['prezime'] as String?,
      DateTime.parse(json['datumRodjenja'] as String),
      json['kategorijaId'] as int?,
      json['ukupnoBodova'] as int?,
    );

Map<String, dynamic> _$TakmicarToJson(Takmicar instance) => <String, dynamic>{
      'id': instance.id,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'datumRodjenja': instance.datumRodjenja.toIso8601String(),
      'kategorijaId': instance.kategorijaId,
      'ukupnoBodova': instance.ukupnoBodova,
    };
