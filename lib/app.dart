import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app_admin_bloc/app_view.dart';
import 'package:pizza_app_admin_bloc/src/blocs/authentication/authentication_bloc.dart';
import 'package:user_repository/user_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) =>
          AuthenticationBloc(userRepository: FirebaseUserRepo()),
      child: const MyAppView(),
    );
  }
}
