import 'dart:io';

import '../../utils/Utils.dart';
import '../License.dart';
import '../Team.dart';
import '../User.dart';
import 'GameType.dart';

// Fills reconeguts de la sealed class:
part 'GamePunts.dart';
part 'GamePuntsCoop.dart';
part 'GameSpeedRun.dart';
part 'GameWL.dart';

sealed class Game<T> {
  final Map<String, T> scores;
  final String name;
  final String code;
  final double preuCompra;
  final double preuLloguer;
  final GameTypes type;
  final Map<String, License> _givenLicenses = {};

  Game(
    this.scores,
    this.name,
    this.code,
    this.preuCompra,
    this.preuLloguer,
    this.type,
  ) {}

  List<String> getHighscores();

  bool checkLicenseNumber(String s) {
    License? l = _givenLicenses[s];
    if (l == null) {
      return false;
    }
    return true;
  }

  License generateSpecificLicence(String type) {
    String id = Utils.generateRandomId(10);
    while (checkLicenseNumber(id)) {
      id = Utils.generateRandomId(10);
    }
    return switch (type) {
      "C" => License.Buy(name, id),
      "L" => License.Rent(name, id),
      "P" => License.Try(name, id),
      _ => License(name, id), // Default
    };
  }

}
