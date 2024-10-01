// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Admin _$AdminFromJson(Map<String, dynamic> json) => Admin(
      (json['id'] as num?)?.toInt(),
      json['ime'] as String?,
      json['telefon'] as String?,
      json['prezime'] as String?,
      (json['mektebId'] as num?)?.toInt(),
      json['status'] as String?,
      json['datumRodjenja'] == null
          ? null
          : DateTime.parse(json['datumRodjenja'] as String),
      json['username'] as String?,
      json['mail'] as String?,
      json['spol'] as String?,
    );

Map<String, dynamic> _$AdminToJson(Admin instance) => <String, dynamic>{
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
