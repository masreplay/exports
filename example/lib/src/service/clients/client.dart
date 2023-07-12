class Client<T> {
  Future<List<T>> getAll() {
    throw UnimplementedError();
  }

  Future<T> getOne() {
    throw UnimplementedError();
  }

  Future<T> create(T body) {
    throw UnimplementedError();
  }

  Future<T> update(T body) {
    throw UnimplementedError();
  }

  Future<void> delete(T body) {
    throw UnimplementedError();
  }
}
