import 'package:rapid_react_scouting/models/teamnumber.dart';

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  String email;
  List<TeamNumber> teams;

  User(this.email, this.teams);
  
  factory User.fromJson(Map<String, dynamic> json) =>
    _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}