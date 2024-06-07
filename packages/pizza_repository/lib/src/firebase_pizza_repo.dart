import 'dart:developer';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pizza_repository/pizza_repository.dart';

class FirebasePizzaRepo implements PizzaRepo {
  final pizzaCollection = FirebaseFirestore.instance.collection('pizzas');

  Future<List<Pizza>> getPizzas() async {
    try {
      var l = await pizzaCollection.get();
      print("LENGTH OF PIZZA GET COLLECTION : ${l.docs.length}");
      return await pizzaCollection.get().then(
            (value) => value.docs.map((e) {
              // var yeh = PizzaEntity.fromDocument(
              //   e.data(),
              // );
              return Pizza.fromEntity(
                PizzaEntity.fromDocument(
                  e.data(),
                ),
              );
            }).toList(),
          );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<String> sendImage(Uint8List file, String name) async {
    // TODO: implement sendImage
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(name);

    await firebaseStorageRef.putData(
        file,
        SettableMetadata(
          contentType: "image/jpeg",
        ));
    return await firebaseStorageRef.getDownloadURL();
  }

  @override
  Future<void> createPizza(Pizza pizza) async {
    try {
      return await pizzaCollection.doc(pizza.pizzaId).set(
            pizza.toEntity().toDocument(),
          );
    } catch (e) {
      log("error create pizza : $e");
      rethrow;
    }
  }
}
