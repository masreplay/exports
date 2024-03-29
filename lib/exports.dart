import 'dart:io';

import 'package:args/args.dart';
import 'package:exports/export_yaml.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;

import 'project_type.dart';

/// project type argument
const String projectType = "project-type";

void main(List<String> arguments) {
  exitCode = 0; // presume success
  final parser = ArgParser()
    ..addFlag(projectType, negatable: false, abbr: 'type');

  final ArgResults argResults = parser.parse(arguments);

  export(
    type: DartProjectType.fromArgs(
      argResults[projectType] ?? DartProjectType.unknown,
    ),
  );
}

/// export files for dart project
Future<void> export({required DartProjectType type}) async {
  final exportsFile = File(ExportYaml.filename);

  final content = exportsFile.existsSync()
      ? ExportYaml.fromFile(exportsFile)
      : ExportYaml.defaultValue;

  stderr.writeln("project type: ${type.name}");
  stderr.writeln("export:");
  stderr.writeln(content.exports.map((e) => "- $e").join('\n'));
  stderr.writeln("ignore:");
  stderr.writeln(content.ignores.map((e) => "- $e").join('\n'));

  final List<String> exports = content.exports;
  final List<String> ignores = content.ignores;

  final ignoreGlobs = ignores.map((path) => Glob(path)).toList();

  for (var path in exports) {
    try {
      var dir = Directory(path);
      createExportFilesRecursively(dir, ignoreGlobs);
    } on PathNotFoundException catch (e) {
      stderr.writeln(e);
    }
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

/// create export file
/// Example:
/// - dir: lib/models/
/// - file: lib/models/models.dart
void createExportFile(Directory dir, List<Glob> ignoreGlobs) {
  final files = dir.listSync(recursive: false);

  final filteredFiles = files.where((file) {
    if (file is File && matchDirAndFileName(dir, file)) {
      return false;
    }

    final isIgnore = !ignoreGlobs.any((Glob glob) => glob.matches(file.path));

    return isIgnore;
  }).toList();

  final exportFile = File('${dir.path}/${dir.path.split("/").last}.dart');
  exportFile.createSync();

  final sink = exportFile.openWrite();

  const String quote = "'";

  for (var entity in filteredFiles) {
    final path = entity.path.replaceFirst('${dir.path}/', '');

    if (entity is File) {
      sink.write("""export $quote$path$quote;\n""");
    } else if (entity is Directory) {
      sink.write(
        """export $quote$path/${path.split("/").last}.dart$quote;\n""",
      );
    }
  }

  sink.close();
}

/// Check if file name match directory name
/// Example:
///  - dir: lib/models/
///  - file: lib/models/models.dart
bool matchDirAndFileName(Directory dir, File file) {
  return file.path.split('/').last.split('.').first == dir.path.split('/').last;
}
