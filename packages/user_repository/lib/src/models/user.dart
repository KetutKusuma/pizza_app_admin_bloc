// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:user_repository/src/entities/entities.dart';

export 'user.dart';

class MyUser {
  String userId;
  String email;
  // String password;
  String name;
  bool hasActiveCart;
  MyUser({
    required this.userId,
    required this.email,
    // required this.password,
    required this.name,
    required this.hasActiveCart,
  });

  static final empty = MyUser(
    userId: '',
    email: '',
    // password: '',
    name: '',
    hasActiveCart: false,
  );

  MyUserEntity toEntity() {
    return MyUserEntity(
      userId: userId,
      email: email,
      name: name,
      hasActiveCart: hasActiveCart,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      userId: entity.name,
      email: entity.email,
      name: entity.name,
      hasActiveCart: entity.hasActiveCart,
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return "MyUser : $userId, $email, $name, $hasActiveCart";
  }
}
