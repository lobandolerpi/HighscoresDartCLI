// Pare de la sealed class:
part of './Game.dart';

class GamePunts extends Game<int> {
  // El constructor recull
  GamePunts({
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

  (String, Map<String, int>) getMaxScore(Map<String, int> scoresPartial) {
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

  @override
  List<String> getHighscores() {
    List<String> hs = [];
    String nextMax = "";
    Map<String, int> scoresNext = Map.of(this.scores);
    while (!scoresNext.isEmpty || hs.length < 10) {
      (nextMax, scoresNext) = getMaxScore(scoresNext);
      hs.add(nextMax);
    }
    return hs;
  }
}
