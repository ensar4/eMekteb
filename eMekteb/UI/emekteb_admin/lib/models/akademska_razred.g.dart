// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'akademska_razred.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AkademskaRazred _$AkademskaRazredFromJson(Map<String, dynamic> json) =>
    AkademskaRazred(
      (json['id'] as num?)?.toInt(),
      (json['akademskaGodinaId'] as num?)?.toInt(),
      (json['razredId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AkademskaRazredToJson(AkademskaRazred instance) =>
    <String, dynamic>{
      'id': instance.id,
      'akademskaGodinaId': instance.akademskaGodinaId,
      'razredId': instance.razredId,
    };
