import 'dart:convert';

import 'package:bitcoin/bloc/data_cubit.dart';
import 'package:bitcoin/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'bloc/data.dart';

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('dataBox');

  // Load data from Hive
  final Box dataBox = Hive.box('dataBox');
  final jsonString = dataBox.get('dataKey');
  Data initialData;

  if (jsonString != null) {
    final Map<String, dynamic> dataMap = jsonDecode(jsonString);
    initialData = Data.fromJson(dataMap);
  } else {
    initialData = Data(
      firstIsActive: false,
      secondIsActive: false,
      moneyThatWeHave: 0.00,
      thirdIsActive: false,
      increment1: 1.0,
      increment2: 100.0,
      increment3: 500.0,
      priceFor2: 50,
      limitForLevel: 100,
      level: 1,
      priceFor1: 10,
      levelGoing: 1,
      numberOfTaps2: 0,
      numberOfTaps3: 0,
      priceFor3: 1000,
      dateTime: DateTime.now(),
      numberOfTaps1: 0,
    );
  }

  runApp(
    MaterialApp(
      theme: theme,
      home: BlocProvider(
        create: (BuildContext context) => DataCubit(initialData),
        child: MainScreen(),
      ),
    ),
  );
}
