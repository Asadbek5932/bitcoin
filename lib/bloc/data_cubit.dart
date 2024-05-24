import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'data.dart';

class DataCubit extends Cubit<Data> {
  Timer? _timer1;
  Timer? _timer2;
  Timer? _timer3;

  DataCubit()
      : super(Data(
          firstIsActive: false,
          secondIsActive: false,
          thirdIsActive: false,
          increment1: 1,
          increment2: 10,
          increment3: 1000,
          moneyThatWeHave: 0,
          level: 1,
          limitForLevel: 5,
          levelGoing: 0,
          priceFor1: 10,
          priceFor2: 40,
          priceFor3: 1000,
          numberOfTaps2: 0,
          numberOfTaps1: 0,
          numberOfTaps3: 0,
        ));

  void incrementValueOfIncrement(int id) {
    switch (id) {
      case 1:
        emit(state.copyWith(increment1: state.increment1 * 1.15, firstIsActive: true));
        break;
      case 2:
        emit(state.copyWith(increment2: state.increment2 * 1.25, secondIsActive: true));
        break;
      case 3:
        emit(state.copyWith(increment3: state.increment3 * 1.25, thirdIsActive: true));
        break;
    }
  }

  void activation(int id) {
    switch(id) {
      case 1:
        emit(state.copyWith(firstIsActive: true));
        break;
      case 2:
        emit(state.copyWith(secondIsActive: true));
        break;
      case 3:
        emit(state.copyWith(thirdIsActive: true));
        break;
    }
  }

  void incrementAutomaticaly(int id) {
    switch (id) {
      case 1:
        emit(state.copyWith(
          moneyThatWeHave: state.moneyThatWeHave + state.increment1,
          levelGoing: state.levelGoing + state.increment1,
        ));
        break;
      case 2:
        emit(state.copyWith(
          moneyThatWeHave: state.moneyThatWeHave + state.increment2,
          levelGoing: state.levelGoing + state.increment2,
        ));
        break;
      case 3:
        emit(state.copyWith(
          moneyThatWeHave: state.moneyThatWeHave + state.increment3,
          levelGoing: state.levelGoing + state.increment3,
        ));
        break;
    }
  }

  void incrementTheMoney() {
    emit(state.copyWith(moneyThatWeHave: state.moneyThatWeHave + 1));
  }

  void incrementTheLevel() {
    emit(state.copyWith(level: state.level + 1));
  }

  void incrementTheLimitForLevel() {
    emit(state.copyWith(limitForLevel: state.limitForLevel * 2.2));
  }

  void setTheLevelGoingToZero() {
    emit(state.copyWith(levelGoing: 0));
  }

  void incrementTheLevelGoing() {
    emit(state.copyWith(levelGoing: state.levelGoing + 1));
  }

  void incrementThePrice(int id) {
    switch (id) {
      case 1:
        emit(state.copyWith(
          moneyThatWeHave: state.moneyThatWeHave - state.priceFor1,
          priceFor1: state.priceFor1 * 1.65,
        ));
        break;
      case 2:
        emit(state.copyWith(
          moneyThatWeHave: state.moneyThatWeHave - state.priceFor2,
          priceFor2: state.priceFor2 * 1.65,
        ));
        break;
      case 3:
        emit(state.copyWith(
          moneyThatWeHave: state.moneyThatWeHave - state.priceFor3,
          priceFor3: state.priceFor3 * 1.65,
        ));
        break;
    }
  }

  void incrementTheNumberOfTaps(int id) {
    switch (id) {
      case 1:
        emit(state.copyWith(numberOfTaps1: state.numberOfTaps1 + 1));
        break;
      case 2:
        emit(state.copyWith(numberOfTaps2: state.numberOfTaps2 + 1));
        break;
      case 3:
        emit(state.copyWith(numberOfTaps3: state.numberOfTaps3 + 1));
        break;
    }
  }

  double getPrice(int id) {
    switch (id) {
      case 1:
        return state.priceFor1;
      case 2:
        return state.priceFor2;
      case 3:
        return state.priceFor3;
      default:
        return 0;
    }
  }

  bool checkAvailability(int id) {
    switch (id) {
      case 1:
        return state.priceFor1 <= state.moneyThatWeHave;
      case 2:
        return state.priceFor2 <= state.moneyThatWeHave;
      case 3:
        return state.priceFor3 <= state.moneyThatWeHave;
      default:
        return false;
    }
  }

  void startTimer(int id) {
    if (id == 1 && (_timer1 == null || !_timer1!.isActive)) {
      _timer1 = Timer.periodic(const Duration(seconds: 1), (timer) {
        incrementAutomaticaly(1);
      });
    } else if (id == 2 && (_timer2 == null || !_timer2!.isActive)) {
      _timer2 = Timer.periodic(const Duration(seconds: 1), (timer) {
        incrementAutomaticaly(2);
      });
    } else if (id == 3 && (_timer3 == null || !_timer3!.isActive)) {
      _timer3 = Timer.periodic(const Duration(seconds: 1), (timer) {
        incrementAutomaticaly(3);
      });
    }
  }

  void stopTimer(int id) {
    if (id == 1) {
      _timer1?.cancel();
      _timer1 = null;
    } else if (id == 2) {
      _timer2?.cancel();
      _timer2 = null;
    } else if (id == 3) {
      _timer3?.cancel();
      _timer3 = null;
    }
  }

  @override
  Future<void> close() {
    stopTimer(1);
    stopTimer(2);
    stopTimer(3);
    return super.close();
  }
}
