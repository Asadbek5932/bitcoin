import 'package:bitcoin/bloc/data.dart';
import 'package:bitcoin/bloc/data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemBottom extends StatelessWidget {
  const ItemBottom(
      {super.key,
      required this.width,
      required this.height,
      required this.icon,
      required this.ravenue,
      required this.sum,
      required this.id});

  final int id;
  final double width;
  final double height;
  final String ravenue;
  final String sum;
  final Icon icon;

  String formatNumber(double number) {
    if (number >= 1e9) {
      return (number / 1e9).toStringAsFixed(2) + 'b';
    } else if (number >= 1e6) {
      return (number / 1e6).toStringAsFixed(2) + 'm';
    } else if (number >= 1e3) {
      return (number / 1e3).toStringAsFixed(2) + 'k';
    } else {
      return number.toStringAsFixed(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool checker = context.watch<DataCubit>().checkAvailability(id);
    return Column(
      children: [
        icon,
        Expanded(
          child: BlocBuilder<DataCubit, Data>(builder: (context, state) {
            switch (id) {
              case 1:
                return Text(
                  '${state.increment1.toStringAsFixed(2)} / sec',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: height / 9),
                );
              case 2:
                return Text(
                  '${formatNumber(state.increment2)} / sec',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: height / 9),
                );
              case 3:
                return Text(
                  '${formatNumber(state.increment3)} / sec',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: height / 9),
                );
              default:
                return Text('comming soon');
            }
          }),
        ),
        Expanded(
          child: BlocBuilder<DataCubit, Data>(builder: (context, state) {
            switch (id) {
              case 1:
                return Text(
                  '${state.numberOfTaps1}',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: height / 5),
                );
              case 2:
                return Text(
                  '${state.numberOfTaps2}',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: height / 5),
                );
              case 3:
                return Text(
                  '${state.numberOfTaps3}',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: height / 5),
                );
              default:
                return const Text(
                  'Comming soon',
                  style: TextStyle(color: Colors.white),
                );
            }
          }),
        ),
        SizedBox(
          height: height / 10,
        ),
        GestureDetector(
          onTap: () {
            if (checker) {
              context.read<DataCubit>().incrementTheNumberOfTaps(id);
              context.read<DataCubit>().incrementValueOfIncrement(id);
              context.read<DataCubit>().startTimer(id);
              context.read<DataCubit>().incrementThePrice(id);
            }
          },
          child: BlocBuilder<DataCubit, Data>(builder: (context, state) {
            var currentPrice = context.read<DataCubit>().getPrice(id);

            return Container(
              height: height / 4,
              width: width,
              color: checker ? Colors.white10 : Colors.white60,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      formatNumber(currentPrice),
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white, fontSize: height / 8),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '+1 /sec',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.green,
                            fontSize: height / 10,
                          ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
