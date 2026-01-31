import 'dart:io';

import '../../practicaJuegos/model/User.dart';
import '../../practicaJuegos/model/UserDB.dart';
import '../model/OptionMenu.dart';
import '../navigation/Navigation.dart';
import '../navigation/Routes.dart';
import '../view/AskData.dart';

class VM01Login{

  AskData ask = AskData();

  // Funcions de les opcions:
  // TANCAR
  void _tOption() {
    print("Adéu, passi-ho bé i moltes gràcies");
    Navigation().goTo(Routes.exit);
  }
  OptionMenu get _optT { 
    return OptionMenu(
      key: "T", 
      description: "[T]ancar app", 
      action: _tOption);
  }

  //REGISTER USER
    void _rOption() {
    String email = ask.askEmail("Indica l'email del nou usuari a enregistrar : ");
    User? u = UserDB().getUser(email);
    if (u != null){
      print("L'usuari ja existeix");
      return;
    }
    String pass = ask.askString("Indica el password del nou usuari a enregistrar : ");
    String nick = ask.askString("Indica el nick del nou usuari a enregistrar : ");
    User uNew = User(email: email, nick: nick, password: pass);
    UserDB().addUser(uNew);
    print("Usuari enRegistrat.");
    return;
  }
  OptionMenu get _optR { 
    return OptionMenu(
      key: "R", 
      description: "[R]egistrar nou usuari", 
      action: _rOption);
  }

  //REGISTER USER
    void _iOption() {
    String email = ask.askEmail("Indica l'email de l'usuari : ");
    User? u = UserDB().getUser(email);
    if (u == null){
      print("L'usuari no existeix");
      return;
    }
    String pass = ask.askString("Indica el password de l'usuari : ");
    if (pass != u.password){
      print("Credencials incorrectes");
      return;
    }
    Navigation().currentUser = u;
    Navigation().goTo(Routes.user);
    return;
  }
  OptionMenu get _optI { 
    return OptionMenu(
      key: "I", 
      description: "Log [I]n", 
      action: _iOption);
  }

  List<OptionMenu> getOptions() {
    return [_optT, _optR, _optI];
  }
}