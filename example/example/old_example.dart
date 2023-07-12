import 'package:example/src/service/clients/users_client.dart';
import 'package:example/src/service/clients/stores_client.dart';
import 'package:example/src/service/models/user.dart';
import 'package:example/src/service/models/category.dart';
import 'package:example/src/service/models/store.dart';
import 'package:example/src/service/models/product.dart';

void main() {
  final usersClient = UsersClient();
  final storesClient = StoresClient();

  final user = User(name: "", age: 0);
  final store = Store(name: "name", location: "location");
  final category = Category(name: "name", icon: "icon");
  final product = Product(name: "name", price: "price", color: "color");

  print(category);
  print(product);

  usersClient.create(user);
  usersClient.delete(user);

  storesClient.create(store);
  storesClient.update(store);
}
