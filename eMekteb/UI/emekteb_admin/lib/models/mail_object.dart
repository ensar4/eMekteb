
import 'package:json_annotation/json_annotation.dart';

part 'mail_object.g.dart';

@JsonSerializable()
class MailObject{
  String? mailAdresa;
  String? subject;
  String? poruka;

  MailObject(
      this.mailAdresa,
      this.subject,
      this.poruka,
      );
  factory MailObject.fromJson(Map<String, dynamic> json) => _$MailObjectFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$MailObjectToJson(this);
}
