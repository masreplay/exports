import 'dart:io';

import 'package:yaml/yaml.dart';

class ExportYaml {
  const ExportYaml({
    required this.exports,
    required this.ignores,
  });

  final List<String> exports;
  final List<String> ignores;

  static const String filename = 'export.yaml';

  static const ExportYaml defaultValue = ExportYaml(
    exports: ["lib/"],
    ignores: [
      "**/*.g.dart",
      "**/*.freezed.dart",
      "**/*.gr.dart",
      "**/*.data.dart",
      "**/*.fields.dart",
      "**/*.arb",
      "**/_*",
      "**/.DS_Store"
    ],
  );

  factory ExportYaml.fromFile(File file) {
    final content = file.readAsStringSync();
    final yaml = loadYaml(content) as YamlMap;

    final export = yaml['export'] as YamlList?;
    final ignore = yaml['ignore'] as YamlList?;

    return ExportYaml(
      exports: export?.map((e) => e.toString()).toList() ?? [],
      ignores: ignore?.map((e) => e.toString()).toList() ?? [],
    );
  }
}
