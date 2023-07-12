import 'dart:io';

import 'package:exports/export_yaml.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;

void main(List<String> arguments) {
  exitCode = 0;

  export();
}

Future<void> export([String? filepath]) async {
  final content = filepath == null
      ? ExportYaml.defaultValue
      : ExportYaml.fromFile(filepath);

  print(content.exports);
  print(content.ignores);

  final List<String> exports = content.exports;
  final List<String> ignores = content.ignores;

  final ignoreGlobs = ignores.map((path) => Glob(path)).toList();

  for (var path in exports) {
    var dir = Directory(path);
    createExportFilesRecursively(dir, ignoreGlobs);
  }
}

void createExportFilesRecursively(Directory dir, List<Glob> ignoreGlobs) {
  final dirName = p.basename(dir.path);

  if (!['lib', 'src'].contains(dirName)) {
    createExportFile(dir, ignoreGlobs);
  }

  final subDirs = dir.listSync(recursive: false).whereType<Directory>();
  for (var subDir in subDirs) {
    createExportFilesRecursively(subDir, ignoreGlobs);
  }
}

void createExportFile(Directory dir, List<Glob> ignoreGlobs) {
  final files = dir.listSync(recursive: false);

  final filteredFiles = files.where((file) {
    if (file is File && matchDirAndFileName(dir, file)) {
      return false;
    }

    return !ignoreGlobs.any((glob) => glob.matches(file.path));
  }).toList();

  final exportFile = File('${dir.path}/${dir.path.split("/").last}.dart');
  exportFile.createSync();

  final sink = exportFile.openWrite();

  for (var entity in filteredFiles) {
    final path = entity.path.replaceFirst('${dir.path}/', '');

    if (entity is File) {
      sink.write('export "$path";\n');
    } else if (entity is Directory) {
      sink.write('export "$path/${path.split("/").last}.dart";\n');
    }
  }

  sink.close();
}

bool matchDirAndFileName(Directory dir, File file) {
  return file.path.split('/').last.split('.').first == dir.path.split('/').last;
}
