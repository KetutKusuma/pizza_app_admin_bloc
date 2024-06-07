import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/blocs/authentication/authentication_bloc.dart';
import 'src/routes/routes.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "PIZZA APP",
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.blue,
          onPrimary: Colors.white,
          surface: Colors.grey.shade200,
          onSurface: Colors.black,
        ),
      ),
      routerConfig: router(
        context.read<AuthenticationBloc>(),
      ),
    );
  }
}
