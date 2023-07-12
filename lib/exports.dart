import 'dart:io';

import 'package:exports/export_yaml.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as path;

void main(List<String> arguments) {
  exitCode = 0; // presume success

  export();
}

Future<void> export([String? filepath]) async {
  final content = filepath == null
      ? ExportYaml.defaultValue
      : ExportYaml.fromFile(filepath);

  print(content.exports);

  final List<String> exports = content.exports;
  final List<String> ignores = content.ignores;

  print('1 + 1 = ...');

  final ignoreGlobs = ignores.map((path) => Glob(path)).toList();

  for (var path in exports) {
    final dir = Directory(path);
    createExportFile(dir, ignoreGlobs);
  }
}

void createExportFile(Directory dir, List<Glob> ignoreGlobs) {
  // Recursively loop through the files and subdirectories
  final files = dir.listSync(recursive: true);

  // Filter out ignored files and directories
  final filteredFiles = files.where((file) {
    return !ignoreGlobs.any((glob) => glob.matches(file.path));
  }).toList();

  // Create new .dart file for exports
  final exportFile =
      File(path.join(dir.path, '${dir.path.split("/").last}.dart'));

  print(exportFile.path);

  exportFile.createSync();

  // Write the exports to the new file
  final sink = exportFile.openWrite();

  for (var entity in filteredFiles) {
    final path =
        entity.path.replaceFirst('${dir.path}/', ''); // Get relative path

    if (entity is File) {
      sink.write('export "$path";\n');
    } else if (entity is Directory) {
      sink.write('export "$path/${path.split("/").last}.dart";\n');
    }
  }

  // Close the IOSink to free system resources.
  sink.close();
}
