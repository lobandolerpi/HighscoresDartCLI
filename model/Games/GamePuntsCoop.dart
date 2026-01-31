// Pare de la sealed class:
part of './Game.dart';

class GamePuntsCoop extends GamePunts {
  final List<Team> teams = [];

  // El constructor recull
  GamePuntsCoop({
    required String name,
    required String code,
    required double preuCompra,
    required double preuLloguer,
    required GameTypes type,
  }) : super(
         name: name,
         code: code,
         preuCompra: preuCompra,
         preuLloguer: preuLloguer,
         type: type,
       ) {
       }
  
  (String, Map<String, int>) getMaxTeamScore(Map<String, int> scoresPartial) {
    String maxS = "";
    if (scoresPartial.isEmpty) {
      return (maxS, scoresPartial);
    }
    Map<String, int> scoresCopy = Map.of(scoresPartial);
    var maxEntry = scoresPartial.entries.first;

    int maxScore = maxEntry.value;
    String maxEmail = maxEntry.key;

    String currentEmail = "";
    int currentScore = 0;
    for (var entry in scoresPartial.entries) {
      currentEmail = entry.key;
      currentScore = entry.value;
      if (currentScore > maxScore) {
        maxEntry = entry;
        maxScore = currentScore;
        maxEmail = currentEmail;
      }
    }
    scoresCopy.remove(maxEmail);
    String out = maxScore.toString() + " " + maxEmail;
    return (out, scoresCopy);
  }
}
