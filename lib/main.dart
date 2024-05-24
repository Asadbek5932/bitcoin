import 'package:bitcoin/bloc/data_cubit.dart';
import 'package:bitcoin/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const seedColor = Colors.deepPurple;
var theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
  appBarTheme: const AppBarTheme(
    color: Color.fromARGB(255, 49, 47, 52),
    titleTextStyle: TextStyle(
        color: Colors.white24,
        fontWeight: FontWeight.bold,
        fontSize: 30,
        fontFamily: 'Papyrus'),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.white54,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
  ),
  useMaterial3: true,
);

void main() {
  runApp(MaterialApp(
    theme: theme,
    home: BlocProvider(
        create: (BuildContext context) => DataCubit(),
        child: const MainScreen()),
  ));
}
