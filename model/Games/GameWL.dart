// Pare de la sealed class:
part of './Game.dart';

class GameWL extends Game<List<bool>> {
  // El constructor recull
  GameWL({
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

  (String, Map<String, List<bool>>) getMaxScore(
    Map<String, List<bool>> scoresPartial,
  ) {
    String maxS = "";
    if (scoresPartial.isEmpty) {
      return (maxS, scoresPartial);
    }
    Map<String, List<bool>> scoresCopy = Map.of(scoresPartial);
    var maxEntry = scoresPartial.entries.first;

    List<bool> maxList = maxEntry.value;
    double maxP = 0.0;
    int maxW = 0;
    String maxEmail = maxEntry.key;
    (maxP, maxW) = getScoreFromList(maxList);
    

    String currentEmail = "";
    List<bool> currentList = [];
    double currentP = 0.0;
    int currentW = 0;

    for (var entry in scoresPartial.entries) {
      currentEmail = entry.key;
      currentList = entry.value;
      (currentP, currentW) = getScoreFromList(currentList);
      if (currentP > maxP || (currentP == maxP && currentW > maxW)) {
        maxEntry = entry;
        maxP = currentP;
        maxW = currentW;
        maxEmail = currentEmail;
      } 
    }
    
    maxP = maxP * 100;
    String out =
        maxP.toStringAsFixed(2) + "% " + maxW.toString() + "W " + maxEmail;
    scoresCopy.remove(maxEmail);
    return (out, scoresCopy);
  }

  (double, int) getScoreFromList(List<bool> listIn) {
    if (listIn.isEmpty) {
      return (0.0, 0);
    }
    int numW = 0;
    int numL = 0;
    for (bool b in listIn) {
      if (b) {
        numW += 1;
      } else {
        numL += 1;
      }
    }
    double perc = numW.toDouble() / (numW + numL);
    return (perc, numW);
  }

  @override
  List<String> getHighscores() {
    List<String> hs = [];
    String nextMax = "";
    Map<String, List<bool>> scoresNext = Map.of(this.scores);
    while (!scoresNext.isEmpty || hs.length < 10) {
      (nextMax, scoresNext) = getMaxScore(scoresNext);
      hs.add(nextMax);
    }
    return hs;
  }
}
