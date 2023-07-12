import '_convertors.dart';

class StringConvertor implements Convertors<String, int> {
  @override
  String fromJson(int json) {
    return json.toString();
  }

  @override
  int toJson(String object) {
    return int.parse(object);
  }
}
