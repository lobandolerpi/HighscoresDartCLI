import '../Team.dart';
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

  Game(
    this.scores,
    this.name,
    this.code,
    this.preuCompra,
    this.preuLloguer,
    this.type,
  ) {}

  List<String> getHighscores();
}
