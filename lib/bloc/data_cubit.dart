import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'dart:convert';
import 'data.dart';

class DataCubit extends Cubit<Data> {
  Timer? _timer1;
  Timer? _timer2;
  Timer? _timer3;
  final Box _dataBox = Hive.box('dataBox');
  final Data _initialData;
  late final int differenceInSeconds;

  DataCubit(this._initialData) : super(_initialData) {
    _calculateDifferenceInSeconds();
    if (_initialData.firstIsActive) {
      startTimer(1);
    }
    if (_initialData.secondIsActive) {
      startTimer(2);
    }
    if (_initialData.thirdIsActive) {
      startTimer(3);
    }
  }

  var newValue;

  void _calculateDifferenceInSeconds() {
    DateTime now = DateTime.now();
    differenceInSeconds = now
        .difference(_initialData.dateTime)
        .inSeconds;
    // print(differenceInSeconds);
    newValue = (((state.firstIsActive ? state.increment1 : 0) +
        (state.secondIsActive ? state.increment2 : 0) +
        (state.thirdIsActive ? state.increment3 : 0)) *
        differenceInSeconds).toDouble();



    emit(state.copyWith(
        moneyThatWeHave: state.moneyThatWeHave + newValue,
        levelGoing: state.levelGoing + newValue));
  }

  double calculatedDifferenceInSeconds() {
    var value = DateTime
        .now()
        .difference(state.dateTime)
        .inSeconds;

    newValue = (((state.firstIsActive ? state.increment1 : 0) +
        (state.secondIsActive ? state.increment2 : 0) +
        (state.thirdIsActive ? state.increment3 : 0)) *
        value).toDouble();

    emit(state.copyWith(
        moneyThatWeHave: state.moneyThatWeHave + newValue,
        levelGoing: state.levelGoing + newValue));

    return newValue;
  }

  void incrementValueOfIncrement(int id) {
    switch (id) {
      case 1:
        emit(state.copyWith(
            increment1:
            state.firstIsActive ? state.increment1 + 1 : state.increment1,
            firstIsActive: true));
        break;
      case 2:
        emit(state.copyWith(
            increment2:
            state.secondIsActive ? state.increment2 + 5 : state.increment2,
            secondIsActive: true));
        break;
      case 3:
        emit(state.copyWith(
            increment3: state.thirdIsActive
                ? state.increment3 + 1000
                : state.increment3,
            thirdIsActive: true));
        break;
    }
  }

  void activation(int id) {
    switch (id) {
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
            dateTime: DateTime.now()));
        break;
      case 2:
        emit(state.copyWith(
            moneyThatWeHave: state.moneyThatWeHave + state.increment2,
            levelGoing: state.levelGoing + state.increment2,
            dateTime: DateTime.now()));
        break;
      case 3:
        emit(state.copyWith(
            moneyThatWeHave: state.moneyThatWeHave + state.increment3,
            levelGoing: state.levelGoing + state.increment3,
            dateTime: DateTime.now()));
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
          priceFor1: state.priceFor1 * 1.1,
        ));
        break;
      case 2:
        emit(state.copyWith(
          moneyThatWeHave: state.moneyThatWeHave - state.priceFor2,
          priceFor2: state.priceFor2 * 1.2,
        ));
        break;
      case 3:
        emit(state.copyWith(
          moneyThatWeHave: state.moneyThatWeHave - state.priceFor3,
          priceFor3: state.priceFor3 * 1.4,
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
        saveDataToHive();
        incrementAutomaticaly(1);
      });
    } else if (id == 2 && (_timer2 == null || !_timer2!.isActive)) {
      _timer2 = Timer.periodic(const Duration(seconds: 1), (timer) {
        saveDataToHive();
        incrementAutomaticaly(2);
      });
    } else if (id == 3 && (_timer3 == null || !_timer3!.isActive)) {
      _timer3 = Timer.periodic(const Duration(seconds: 1), (timer) {
        saveDataToHive();
        incrementAutomaticaly(3);
      });
    }
  }

  void startTimers() {

    if (state.firstIsActive && (_timer1 == null || !_timer1!.isActive)) {
      _timer1 = Timer.periodic(const Duration(seconds: 1), (timer) {
        saveDataToHive();
        incrementAutomaticaly(1);
      });
    } else if (state.secondIsActive == 2 && (_timer2 == null || !_timer2!.isActive)) {
      _timer2 = Timer.periodic(const Duration(seconds: 1), (timer) {
        saveDataToHive();
        incrementAutomaticaly(2);
      });
    } else if (state.thirdIsActive == 3 && (_timer3 == null || !_timer3!.isActive)) {
      _timer3 = Timer.periodic(const Duration(seconds: 1), (timer) {
        saveDataToHive();
        incrementAutomaticaly(3);
      });
    }
  }

  void stopTimer() async {
    await saveDataToHive();
    _timer1?.cancel();
    _timer1 = null;

    _timer2?.cancel();
    _timer2 = null;

    _timer3?.cancel();
    _timer3 = null;
  }

  Future<void> saveDataToHive() async {
    final dataMap = state.toJson();
    final jsonString = jsonEncode(dataMap);
    await _dataBox.put('dataKey', jsonString);
  }

  Future<void> loadDataFromHive() async {
    final jsonString = _dataBox.get('dataKey');
    if (jsonString != null) {
      final dataMap = jsonDecode(jsonString);
      final data = Data.fromJson(dataMap);
      emit(data);
    }
  }

  @override
  Future<void> close() async {
    await saveDataToHive();
    return super.close();
  }
}
