// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mualim.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mualim _$MualimFromJson(Map<String, dynamic> json) => Mualim(
      json['id'] as int?,
      json['ime'] as String?,
      json['telefon'] as String?,
      json['prezime'] as String?,
      json['mektebId'] as int?,
      json['status'] as String?,
      json['datumRodjenja'] == null
          ? null
          : DateTime.parse(json['datumRodjenja'] as String),
      json['username'] as String?,
      json['mail'] as String?,
      json['spol'] as String?,
    );

Map<String, dynamic> _$MualimToJson(Mualim instance) => <String, dynamic>{
      'id': instance.id,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'username': instance.username,
      'telefon': instance.telefon,
      'status': instance.status,
      'mail': instance.mail,
      'spol': instance.spol,
      'datumRodjenja': instance.datumRodjenja?.toIso8601String(),
      'mektebId': instance.mektebId,
    };