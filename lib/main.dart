import 'package:fampay/cubit/card_cubit/card_cubit.dart';
import 'package:fampay/cubit/data_cubit/data_cubit.dart';
import 'package:fampay/cubit/slider_cubit/slider_cubit.dart';
import 'package:fampay/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fam',
      theme: lightTheme(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=>DataCubit()..loadData()),
        BlocProvider(create: (_)=>SaveCardCubit()..loadSavedCards()),
        BlocProvider(create: (_)=>SliderCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            'assets/images/fampay_logo.png',
          ),
        ),
        body: const Home(),
      ),
    );
  }
}
