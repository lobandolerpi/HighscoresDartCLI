import 'dart:io';

import '../model/AppData.dart';
import '../model/Games/Game.dart';
import '../model/Games/GameType.dart';
import '../model/License.dart';
import '../model/User.dart';
import '../model/UserDB.dart';
import '../model/OptionMenu.dart';
import '../navigation/Navigation.dart';
import '../navigation/Routes.dart';
import '../view/AskData.dart';

class VM02User {
  AskData ask = AskData();
  User? cU = Navigation().currentUser;

  bool checkUser() {
    if (cU == null) {
      print("BUG, no hi ha usuari actiu!");
      Navigation().currentUser = null;
      Navigation().goTo(Routes.login);
      return false;
    }
    return true;
  }

  // Funcions de les opcions:
  // TANCAR
  void _tOption() {
    print("Adéu, passi-ho bé i moltes gràcies");
    Navigation().goTo(Routes.exit);
  }

  OptionMenu get _optT {
    return OptionMenu(key: "T", description: "[T]ancar app", action: _tOption);
  }

  // ENRERA
  void _eOption() {
    String eMail = cU?.email ?? "BUG: USUARI NO TROBAT";

    print("L'usuari " + eMail + " ja no és actiu.");
    Navigation().currentUser = null;
    Navigation().goTo(Routes.login);
  }

  OptionMenu get _optE {
    return OptionMenu(key: "E", description: "[E]nrera", action: _eOption);
  }

  // JUGAR
  bool _jOption() {
    if (checkUser()) {
      User u = cU as User;
      print("--- Jocs disponibles: ---");
      List<String> listGames = u.availableGames();
      ask.printList(listGames);
      String gName = ask.askString("A quin joc vols jugar?");
      if (!listGames.contains(gName)) {
        print("No tens llicència per aquest joc");
        return false;
      }
      Game? g = AppData().getGame(gName);
      if (g == null) {
        print("BUG, la llicència és d'un joc que ja no existeix");
        return false;
      }
      String? userLicence = u.getLicenseNumber(g.name);
      if (userLicence == null || !g.checkLicenseNumber(userLicence)) {
        print("ERROR llicència no reconeguda");
        return false;
      }
      Navigation().currentGame = g;
      Navigation().goTo(Routes.game);
      return true;
    }
    return false;
  }

  OptionMenu get _optJ {
    return OptionMenu(
      key: "J",
      description: "[J]ugar a un joc",
      action: _jOption,
    );
  }

  // BOTIGA
  void _bOption() {
    print("-- Tipus de joc de la botiga --");
    List<String> accepted = [];
    int counter = 0;
    for (var value in GameTypes.values) {
      counter++;
      String option = counter.toString();
      accepted.add(option);
      print("[" + option + "] " + value.toString());
    }
    String typeSelected = ask.askStringInList(
      "Selecciona tipus de joc a mostrar",
      accepted,
    );
    if (!accepted.contains(typeSelected)) {
      print("opció no vàlida");
    }
    for (var entry in AppData().games.entries) {
      Game g = entry.value;
      if (g.type == typeSelected) {
        print(g.code + " " + g.name);
      }
    }
  }

  OptionMenu get _optB {
    return OptionMenu(
      key: "B",
      description: "[B]otiga, llistar jocs",
      action: _bOption,
    );
  }

  Game? askForGame() {
    String codeG = ask.askString("Escriu el codi del joc: ");
    Game? gN = AppData().getGame(codeG);
    if (gN == null) {
      print("El joc no existeix");
      return gN;
    }
  }

  void _cOption() {
    if (checkUser()) {
      User u = cU as User;
      print("Comprar joc");
      Game? gN = askForGame();
      if (gN != null) {
        License l = gN.generateSpecificLicence("C");
        u.addLicense(l);
      }
    }
  }

  OptionMenu get _optC {
    return OptionMenu(key: "C", 
    description: "[C]omprar joc", 
    action: _cOption);
  }

  void _lOption() {
    if (checkUser()) {
      User u = cU as User;
      print("Llogar joc");
      Game? gN = askForGame();
      if (gN != null) {
        License l = gN.generateSpecificLicence("L");
        u.addLicense(l);
      }
    }
  }

  OptionMenu get _optL {
    return OptionMenu(key: "L", 
    description: "[L]logar joc", 
    action: _cOption);
  }

  void _pOption() {
    if (checkUser()) {
      User u = cU as User;
      print("Provar joc");
      Game? gN = askForGame();
      if (gN != null) {
        License l = gN.generateSpecificLicence("L");
        u.addLicense(l);
      }
    }
  }

  OptionMenu get _optP {
    return OptionMenu(key: "P", 
    description: "[P]logar joc", 
    action: _cOption);
  }

  void _aOption() {
    if (checkUser()) {
      User u = cU as User;
      print("Llistat d'amics");
      ask.printList(u.listFriends());
    }
  }

  OptionMenu get _optA {
    return OptionMenu(key: "A", 
    description: "Llistat d'[A]mics", 
    action: _aOption);
  }

  void _dOption() {
    if (checkUser()) {
      User u = cU as User;
      List<String> listJocs = u.llistarJocsDonables();
      if (listJocs.isEmpty){
        print("No tens cap joc donable");
        return;
      }
      List<String> friends = u.listFriends();
      if (friends.isEmpty){
        print("No tens cap amic");
        return;
      }
      print("Llistat de jocs");
      ask.printList(listJocs);
      String gTxt = ask.askString("Introdueix codi del joc a donar : ");
      if (!listJocs.contains(gTxt)){
        print("Codi de joc no està a la llista de donables");
        return;
      }

      print("Llistat d'amics");
      ask.printList(friends);
      String fTxt = ask.askString("Introdueix email de l'amic : ");
      if (!friends.contains(fTxt)){
        print("L'amic no està a la llista");
        return;
      }
      u.donarJoc(gTxt, fTxt);
    }
  }

  OptionMenu get _optD {
    return OptionMenu(key: "D", 
    description: "[D]onar joc", 
    action: _dOption);
  }




  List<OptionMenu> getOptions() {
    return [_optT, _optE, _optJ, _optB, _optC, _optL, _optP, _optA, _optD];
  }

}
