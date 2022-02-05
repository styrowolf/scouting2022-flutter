import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:json_annotation/json_annotation.dart';

part 'credentials.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Credentials {
  static const _storage = FlutterSecureStorage();
  static const _key = "rrsapp-credentials-json";
  String email;
  String password;

  Credentials(this.email, this.password);

  static Future<Credentials?> fromStorage() async {
    String? jsonString = await _storage.read(key: _key);
    if (jsonString != null) {
      return Credentials.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  Future<void> toStorage() async {
    await _storage.write(key: _key, value: jsonEncode(toJson()));
  }
  
  factory Credentials.fromJson(Map<String, dynamic> json) =>
    _$CredentialsFromJson(json);
  Map<String, dynamic> toJson() => _$CredentialsToJson(this);
}