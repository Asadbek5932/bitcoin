import 'package:intl/intl.dart';

class Data {
  final double moneyThatWeHave;
  final double increment1;
  final double priceFor1;
  final double priceFor2;
  final double priceFor3;
  final int numberOfTaps1;
  final int numberOfTaps2;
  final int numberOfTaps3;
  final int level;
  final double limitForLevel;
  final double levelGoing;
  final double increment2;
  final double increment3;
  final bool firstIsActive;
  final bool secondIsActive;
  final bool thirdIsActive;
  final DateTime dateTime;

  Data({
    required this.firstIsActive,
    required this.secondIsActive,
    required this.thirdIsActive,
    required this.moneyThatWeHave,
    required this.increment1,
    required this.increment2,
    required this.increment3,
    required this.level,
    required this.limitForLevel,
    required this.levelGoing,
    required this.priceFor1,
    required this.priceFor2,
    required this.priceFor3,
    required this.numberOfTaps2,
    required this.numberOfTaps3,
    required this.numberOfTaps1,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final String formattedDateTime = formatter.format(dateTime);

    return {
      'moneyThatWeHave': moneyThatWeHave,
      'increment1': increment1,
      'increment2': increment2,
      'increment3': increment3,
      'level': level,
      'limitForLevel': limitForLevel,
      'levelGoing': levelGoing,
      'priceFor1': priceFor1,
      'priceFor2': priceFor2,
      'priceFor3': priceFor3,
      'numberOfTaps1': numberOfTaps1,
      'numberOfTaps2': numberOfTaps2,
      'numberOfTaps3': numberOfTaps3,
      'firstIsActive': firstIsActive,
      'secondIsActive': secondIsActive,
      'thirdIsActive': thirdIsActive,
      'dateTime': formattedDateTime,
    };
  }

  factory Data.fromJson(Map<String, dynamic> json) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final DateTime dateTime = formatter.parse(json['dateTime']);

    return Data(
      moneyThatWeHave: json['moneyThatWeHave'],
      increment1: json['increment1'],
      increment2: json['increment2'],
      increment3: json['increment3'],
      level: json['level'],
      limitForLevel: json['limitForLevel'],
      levelGoing: json['levelGoing'],
      priceFor1: json['priceFor1'],
      priceFor2: json['priceFor2'],
      priceFor3: json['priceFor3'],
      numberOfTaps1: json['numberOfTaps1'],
      numberOfTaps2: json['numberOfTaps2'],
      numberOfTaps3: json['numberOfTaps3'],
      firstIsActive: json['firstIsActive'],
      secondIsActive: json['secondIsActive'],
      thirdIsActive: json['thirdIsActive'],
      dateTime: dateTime,
    );
  }

  Data copyWith({
    double? moneyThatWeHave,
    double? increment1,
    double? increment2,
    double? increment3,
    int? level,
    double? limitForLevel,
    double? levelGoing,
    double? priceFor1,
    int? numberOfTaps1,
    int? numberOfTaps2,
    int? numberOfTaps3,
    double? priceFor2,
    double? priceFor3,
    bool? firstIsActive,
    bool? secondIsActive,
    bool? thirdIsActive,
    DateTime? dateTime
  }) {
    return Data(
      firstIsActive: firstIsActive ?? this.firstIsActive,
      secondIsActive: secondIsActive ?? this.secondIsActive,
      thirdIsActive: thirdIsActive ?? this.thirdIsActive,
      increment2: increment2 ?? this.increment2,
      increment3: increment3 ?? this.increment3,
      numberOfTaps1: numberOfTaps1 ?? this.numberOfTaps1,
      numberOfTaps2: numberOfTaps2 ?? this.numberOfTaps2,
      numberOfTaps3: numberOfTaps3 ?? this.numberOfTaps3,
      moneyThatWeHave: moneyThatWeHave ?? this.moneyThatWeHave,
      increment1: increment1 ?? this.increment1,
      level: level ?? this.level,
      limitForLevel: limitForLevel ?? this.limitForLevel,
      levelGoing: levelGoing ?? this.levelGoing,
      priceFor1: priceFor1 ?? this.priceFor1,
      priceFor2: priceFor2 ?? this.priceFor2,
      priceFor3: priceFor3 ?? this.priceFor3,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
