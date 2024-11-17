// main.dart
import 'package:bookia/features/auth/bloc/auth_bloc.dart';
import 'package:bookia/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        title: 'Bookia Demo',
        theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(color: Colors.white)),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
