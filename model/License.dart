import '../view/AskData.dart';

class License {
  final String ID;
  final String gameName;
  int numChanges = 0;
  int timeRemaining = 0;
  int _formatLicense = 10;

  factory License(String gameName, String ID){
    AskData ask = AskData();
    String question = "Quin tipus de llicència \n [C] Compra \n [L] Lloger \n [P] Prova";
    List<String> opcionsAcceptades = ["C","L","P"];
    String option = ask.askStringInList(question, opcionsAcceptades);

    switch (option) {
      case "C":
        return License.Buy(gameName, ID);
      case "L":
        return License.Rent(gameName, ID);
      case "P":
        return License.Try(gameName, ID);
      default:
        // Fallback (shouldn't happen due to askStringInList)
        return License.Buy(gameName, ID);
    }
  }

  License.Buy(this.gameName, this.ID){
    numChanges    = 3;
    timeRemaining = -1;
    //if (ID.length != _formatLicense) {
    //  throw FormatException("ID ha de tenir exactament 10 characters.  ${ID.length}");
    //}
  }

  License.Rent(this.gameName, this.ID){
    numChanges    = 0;
    timeRemaining = -1;
    //if (ID.length != _formatLicense) {
    //  throw FormatException("ID ha de tenir exactament 10 characters.  ${ID.length}");
    //}
  }

  License.Try(this.gameName, this.ID){
    numChanges    = 0;
    timeRemaining = 3;
    //if (ID.length != _formatLicense) {
    //  throw FormatException("ID ha de tenir exactament 10 characters.  ${ID.length}");
    //}
  }
}