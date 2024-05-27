import 'package:bitcoin/bloc/data.dart';
import 'package:bitcoin/bloc/data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Toolbar extends StatelessWidget {
  const Toolbar({super.key});

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
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10, bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 30,
              ),
              BlocBuilder<DataCubit, Data>(builder: (context, state) {
                return Text(
                  "Level ${state.level}",
                  style: Theme.of(context).textTheme.titleLarge,
                );
              }),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: 100,
                child: BlocBuilder<DataCubit, Data>(
                  builder: (context, state) {
                    if (state.levelGoing >= state.limitForLevel * 10) {
                      context.read<DataCubit>().incrementTheLevel();
                      context.read<DataCubit>().incrementTheLimitForLevel();
                      context.read<DataCubit>().setTheLevelGoingToZero();
                    }
                    return LinearProgressIndicator(
                      minHeight: 6,
                      value: state.levelGoing / (state.limitForLevel * 10),
                      color: Colors.blueAccent,
                      backgroundColor: Colors.black,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<DataCubit, Data>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/images/bitcoin.png'),
                    ),
                    const SizedBox(width: 5,),
                    Text(
                      formatNumber(state.moneyThatWeHave),
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 30, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Text(
                  '${formatNumber((state.firstIsActive ? state.increment1 : 0) + (state.secondIsActive ? state.increment2 : 0) + (state.thirdIsActive ? state.increment3 : 0))}/sec',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.pink,
                      ),
                )
              ],
            );
          },
        ),
        SizedBox(width: MediaQuery.of(context).size.width / 4),
      ],
    );
  }
}
