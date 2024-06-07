import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza_app_admin_bloc/src/moduls/auth/blocs/sign_in/sign_in_bloc.dart';
import 'package:pizza_app_admin_bloc/src/moduls/auth/views/login_screen.dart';
import 'package:pizza_app_admin_bloc/src/moduls/base/views/base_screen.dart';
import 'package:pizza_app_admin_bloc/src/moduls/create_pizza/blocs/create_pizza/create_pizza_bloc.dart';
import 'package:pizza_app_admin_bloc/src/moduls/create_pizza/blocs/upload_picture/upload_picture_bloc.dart';
import 'package:pizza_app_admin_bloc/src/moduls/create_pizza/views/create_pizza_screen.dart';
import 'package:pizza_app_admin_bloc/src/moduls/home/views/home_screen.dart';
import 'package:pizza_app_admin_bloc/src/moduls/splash/views/splash_screen.dart';
import 'package:pizza_repository/pizza_repository.dart';

import '../blocs/authentication/authentication_bloc.dart';

final _navKey = GlobalKey<NavigatorState>();
final _shellNavigationKey = GlobalKey<NavigatorState>();

GoRouter router(AuthenticationBloc authBloc) {
  return GoRouter(
    navigatorKey: _navKey,
    initialLocation: '/',
    redirect: (context, state) {
      if (authBloc.state.status == AuthenticationStatus.unknown) {
        return '/';
      }
      return null;
    },
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigationKey,
        builder: (context, state, child) {
          if (state.fullPath == '/login' || state.fullPath == '/') {
            return child;
          } else {
            return BlocProvider<SignInBloc>(
              create: (context) => SignInBloc(
                context.read<AuthenticationBloc>().userRepository,
              ),
              child: BaseScreen(
                child: child,
              ),
            );
          }
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => BlocProvider<AuthenticationBloc>.value(
              value: BlocProvider.of<AuthenticationBloc>(context),
              child: const SplashScreen(),
            ),
          ),
          GoRoute(
            path: '/login',
            builder: (context, state) => BlocProvider<AuthenticationBloc>.value(
              value: BlocProvider.of<AuthenticationBloc>(context),
              child: BlocProvider<SignInBloc>(
                create: (context) => SignInBloc(
                    context.read<AuthenticationBloc>().userRepository),
                child: const SignInScreen(),
              ),
            ),
          ),
          GoRoute(
            path: '/home',
            // builder: (context, state) => BlocProvider<AuthenticationBloc>.value(
            //   value: BlocProvider.of<AuthenticationBloc>(context),
            //   child: const HomeScreen(),
            // ),
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/create',
            // builder: (context, state) => BlocProvider<AuthenticationBloc>.value(
            //   value: BlocProvider.of<AuthenticationBloc>(context),
            //   child: const PizzaCreateScreen(),
            // ),
            builder: (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => UploadPictureBloc(
                    FirebasePizzaRepo(),
                  ),
                ),
                BlocProvider(
                  create: (context) => CreatePizzaBloc(
                    FirebasePizzaRepo(),
                  ),
                ),
              ],
              child: const CreatePizzaScreen(),
            ),
          ),
        ],
      )
    ],
  );
}
