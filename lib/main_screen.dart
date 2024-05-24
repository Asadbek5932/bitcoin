import 'package:bitcoin/bloc/data_cubit.dart';
import 'package:bitcoin/widgets/item_bottom.dart';
import 'package:bitcoin/widgets/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 7,
        leadingWidth: MediaQuery.of(context).size.width,
        leading: const Toolbar(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          ElevatedButton(
              onPressed: () {
                context.read<DataCubit>().incrementTheMoney();
                context.read<DataCubit>().incrementTheLevelGoing();
              },
              child: const Icon(Icons.add)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  height: height / 5,
                  width: MediaQuery.of(context).size.width / 3,
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
                  width: MediaQuery.of(context).size.width / 3,
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
                  width: MediaQuery.of(context).size.width / 3,
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
                  width: MediaQuery.of(context).size.width / 3,
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
