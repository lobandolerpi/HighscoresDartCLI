// Pare de la sealed class:
part of './Game.dart';

class GamePuntsCoop extends GamePunts {
  final Map<String, Team> teams = {};

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
  
  (String, Map<String, Team>) getMaxTeamScore(Map<String, Team> teamsIn) {
    String maxS = "";
    if (teamsIn.isEmpty) {
      return (maxS, teamsIn);
    }
    Map<String, Team> teamsCopy = Map.of(teamsIn);
    var maxEntry = teamsIn.entries.first;
    Team maxTeam = maxEntry.value;
    int maxTeamScore = computeTeamScore(maxTeam);
    String maxTeamName = maxEntry.key;

    String currentTeamName= "";
    int currentTeamScore = 0;
    Team currentTeam;
    for (var entry in teamsCopy.entries) {
      currentTeamName = entry.key;
      currentTeam = entry.value;
      currentTeamScore = computeTeamScore(currentTeam);
      if (currentTeamScore > maxTeamScore) {
        maxEntry = entry;
        maxTeamScore = currentTeamScore;
        currentTeamName = entry.key;
        maxTeam = currentTeam;
      }
    }
    teamsCopy.remove(currentTeamName);
    String out = maxTeamScore.toString() + " " + currentTeamName;
    return (out, teamsCopy);
  }

  int computeTeamScore(Team t){
    int teamScore = 0;
    for (User u in t.users){
      var entryU = scores[u.email];
      int userScore = 0;
      if (entryU == null){
        print("BUG: usuari de l'equip no hi és a la llista de pubtuacions");
      } else {
        userScore = entryU;
      }
      teamScore += userScore;
    }
    return teamScore;
  }

  @override
  List<String> getHighscores() {
    List<String> hs = [];
    String nextMaxTxt = "";
    Map<String, Team> teamsNext = Map.of(this.teams);
    while (!teamsNext.isEmpty || hs.length < 10) {
      (nextMaxTxt, teamsNext) = getMaxTeamScore(teamsNext);
      hs.add(nextMaxTxt);
    }
    return hs;
  }
}
