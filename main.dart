import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'di/di.dart';
import 'models/library_item.dart';
import 'pages/detail_page.dart';
import 'pages/home/bloc/home_bloc.dart';
import 'pages/home/home_page.dart';
import 'pages/loading_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'routes.dart';
import 'services/auth_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Онлайн-библиотека',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
      ),
      initialRoute: Routes.loading,
      routes: {
        Routes.loading: (context) => const LoadingPage(),
        Routes.login: (context) => const LoginPage(),
        Routes.register: (context) => const RegisterPage(),
        Routes.home: (context) {
          final user = ModalRoute.of(context)!.settings.arguments as AppUser;
          return BlocProvider(
            create: (_) => getIt<HomeBloc>()..add(const LoadLibraryEvent()),
            child: HomePage(user: user),
          );
        },
        Routes.detail: (context) {
          final item =
          ModalRoute.of(context)!.settings.arguments as LibraryItem;
          return DetailPage(item: item);
        },
      },
    );
  }
}