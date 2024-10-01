// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'akademska_mekteb.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AkademskaMekteb _$AkademskaMektebFromJson(Map<String, dynamic> json) =>
    AkademskaMekteb(
      (json['id'] as num?)?.toInt(),
      (json['akademskaGodinaId'] as num?)?.toInt(),
      (json['mektebId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AkademskaMektebToJson(AkademskaMekteb instance) =>
    <String, dynamic>{
      'id': instance.id,
      'akademskaGodinaId': instance.akademskaGodinaId,
      'mektebId': instance.mektebId,
    };
