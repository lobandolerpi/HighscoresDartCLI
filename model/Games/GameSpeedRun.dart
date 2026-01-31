// Pare de la sealed class:
part of './Game.dart';

class GameSpeedRun extends Game<Duration> {
  // El constructor recull
  GameSpeedRun({
    required String name,
    required String code,
    required double preuCompra,
    required double preuLloguer,
    required GameTypes type,
  })
    // ...i passa a al pare via "super"
    : super(
         {}, // Diccionari buit
         name,
         code,
         preuCompra,
         preuLloguer,
         type,
       );

  (String, Map<String, Duration>) getMaxScore(
    Map<String, Duration> scoresPartial,
  ) {
    String maxS = "";
    if (scoresPartial.isEmpty) {
      return (maxS, scoresPartial);
    }
    Map<String, Duration> scoresCopy = Map.of(scoresPartial);
    var maxEntry = scoresPartial.entries.first;

    Duration maxScore = maxEntry.value;
    String maxEmail = maxEntry.key;

    String currentEmail = "";
    Duration currentScore = Duration();
    for (var entry in scoresPartial.entries) {
      currentEmail = entry.key;
      currentScore = entry.value;
      if (currentScore < maxScore) {
        maxEntry = entry;
        maxScore = currentScore;
        maxEmail = currentEmail;
      }
    }
    scoresCopy.remove(maxEmail);
    String out = maxScore.toString() + " " + maxEmail;
    return (out, scoresCopy);
  }

  @override
  List<String> getHighscores() {
    List<String> hs = [];
    String nextMax = "";
    Map<String, Duration> scoresNext = Map.of(this.scores);
    while (!scoresNext.isEmpty || hs.length < 10) {
      (nextMax, scoresNext) = getMaxScore(scoresNext);
      hs.add(nextMax);
    }
    return hs;
  }
}
