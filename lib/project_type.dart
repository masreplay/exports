import 'dart:io';

import 'package:yaml/yaml.dart';

enum DartProjectType {
  flutter,
  dart,
  dartPackage,
  unknown;

  factory DartProjectType.fromArgs(String? value) {
    if (value == null) {
      return DartProjectType.fromPubspecYaml();
    } else {
      return DartProjectType.fromJson(value);
    }
  }

  factory DartProjectType.fromJson(String value) {
    switch (value) {
      case 'flutter':
        return flutter;
      case 'dart':
        return dart;
      case 'dart-package':
        return dartPackage;
      default:
        return unknown;
    }
  }

  factory DartProjectType.fromPubspecYaml() {
    final file = File('pubspec.yaml');

    if (file.existsSync()) {
      return DartProjectType.unknown;
    }

    final content = loadYaml(file.readAsStringSync());

    if (content.containsKey('flutter')) {
      return DartProjectType.flutter;
    } else if (content.containsKey('dependencies')) {
      return DartProjectType.dartPackage;
    } else {
      return DartProjectType.dart;
    }
  }
}
