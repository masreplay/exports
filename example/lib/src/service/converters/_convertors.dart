abstract class Convertors<T, F> {
  T fromJson(F json);
  F toJson(T object);
}
