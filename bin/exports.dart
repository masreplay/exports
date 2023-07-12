import 'package:exports/exports.dart' as exports;
import 'package:exports/project_type.dart';

void main(List<String> arguments) {
  exports.export(type: DartProjectType.fromArgs(arguments.firstOrNull));
}
