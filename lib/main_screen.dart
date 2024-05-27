import 'package:bitcoin/bloc/data.dart';
import 'package:bitcoin/bloc/data_cubit.dart';
import 'package:bitcoin/widgets/item_bottom.dart';
import 'package:bitcoin/widgets/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  // final Data initialData;

  MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        displayDialog(context);
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  String formatNumber(double number) {
    if (number >= 1e12) {
      return '${(number / 1e12).toStringAsFixed(2)}t';
    } else if (number >= 1e9) {
      return '${(number / 1e9).toStringAsFixed(2)}b';
    } else if (number >= 1e6) {
      return '${(number / 1e6).toStringAsFixed(2)}m';
    } else if (number >= 1e3) {
      return '${(number / 1e3).toStringAsFixed(2)}k';
    } else {
      return number.toStringAsFixed(2);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // Show dialog when app is resumed
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          displayDialog(context);
          context.read<DataCubit>().startTimers();
        }
      });
    }
    if (state == AppLifecycleState.paused) {
      context.read<DataCubit>().stopTimer();
    }
  }

  void displayDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.watch_later_rounded,
                      size: 60,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      formatNumber(context
                          .read<DataCubit>()
                          .calculatedDifferenceInSeconds()),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                          fontSize: 60,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200, // Set the desired width
                height: 65, // Set the desired height
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.grey,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 50,
                      color: Colors.white,
                    )),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: AppBar(
        toolbarHeight: height / 7,
        leadingWidth: width,
        leading: const Toolbar(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          InkWell(
            onTap: () {
              context.read<DataCubit>().incrementTheMoney();
              context.read<DataCubit>().incrementTheLevelGoing();
            },
            // focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: const CircleAvatar(
              radius: 92,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/bitcoin.png'),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  height: height / 5,
                  width: width / 3,
                  decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    border: const Border.symmetric(
                      vertical: BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: ItemBottom(
                    height: height / 5,
                    width: width / 3,
                    icon: const Icon(
                      Icons.ac_unit,
                      size: 40,
                      color: Colors.white24,
                    ),
                    ravenue: '0.00',
                    sum: '12',
                    id: 1,
                  ),
                ),
                Container(
                  height: height / 5,
                  width: width / 3,
                  decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    border: const Border.symmetric(
                      vertical: BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: ItemBottom(
                    height: height / 5,
                    width: width / 3,
                    icon: const Icon(
                      Icons.add,
                      size: 40,
                      color: Colors.white24,
                    ),
                    ravenue: '0.00',
                    sum: '12',
                    id: 2,
                  ),
                ),
                Container(
                  height: height / 5,
                  width: width / 3,
                  decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    border: const Border.symmetric(
                      vertical: BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: ItemBottom(
                    height: height / 5,
                    width: width / 3,
                    icon: const Icon(
                      Icons.mobile_friendly,
                      size: 40,
                      color: Colors.white24,
                    ),
                    ravenue: '0.00',
                    sum: '12',
                    id: 3,
                  ),
                ),
                Container(
                  height: height / 5,
                  width: width / 3,
                  decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    border: const Border.symmetric(
                      vertical: BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: ItemBottom(
                    height: height / 5,
                    width: width / 3,
                    icon: const Icon(
                      Icons.ac_unit,
                      size: 40,
                      color: Colors.white24,
                    ),
                    ravenue: '0.00',
                    sum: '12',
                    id: 4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
