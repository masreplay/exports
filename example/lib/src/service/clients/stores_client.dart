import 'package:example/src/service/clients/client.dart';
import 'package:example/src/service/models/models.dart';

class StoresClient implements Client<Store> {
  const StoresClient();

  @override
  Future<Store> create(Store body) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(Store body) {
    throw UnimplementedError();
  }

  @override
  Future<List<Store>> getAll() {
    throw UnimplementedError();
  }

  @override
  Future<Store> getOne() {
    throw UnimplementedError();
  }

  @override
  Future<Store> update(Store body) {
    throw UnimplementedError();
  }
}
