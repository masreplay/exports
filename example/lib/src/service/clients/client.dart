class Client<T> {
  Future<List<T>> getAll() {
    throw UnimplementedError();
  }

  Future<T> getOne() {
    throw UnimplementedError();
  }

  Future<T> create() {
    throw UnimplementedError();
  }

  Future<T> update() {
    throw UnimplementedError();
  }

  Future<void> delete() {
    throw UnimplementedError();
  }
}
