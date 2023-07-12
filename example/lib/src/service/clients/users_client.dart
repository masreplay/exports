import 'package:example/src/service/clients/client.dart';
import 'package:example/src/service/models/models.dart';

class UsersClient implements Client<User> {
  const UsersClient();

  @override
  Future<User> create() {
    throw UnimplementedError();
  }

  @override
  Future<void> delete() {
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getAll() {
    throw UnimplementedError();
  }

  @override
  Future<User> getOne() {
    throw UnimplementedError();
  }

  @override
  Future<User> update() {
    throw UnimplementedError();
  }
}
