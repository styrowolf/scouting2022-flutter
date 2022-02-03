import 'package:hex/hex.dart';
import 'dart:convert';

abstract class Identifiable {
  String get prefix;
  String get id;

  void assignId();
  String generateId(String deriveFrom) {
    return prefix + const HexEncoder().convert(utf8.encode(deriveFrom));
  }

  @override
  bool operator ==(Object other) => hashCode == other.hashCode;

  @override
  int get hashCode => id.hashCode;
}