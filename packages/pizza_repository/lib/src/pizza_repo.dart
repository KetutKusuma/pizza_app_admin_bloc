import 'dart:typed_data';
import 'package:pizza_repository/pizza_repository.dart';

abstract class PizzaRepo {
  Future<List<Pizza>> getPizzas();
  Future<String> sendImage(Uint8List file, String name);
  Future<void> createPizza(Pizza pizza);
}
