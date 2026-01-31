import 'dart:io';

import '../view/Screen.dart';
import '../view/ScreenGame.dart';
import '../view/ScreenLogin.dart';
import '../view/ScreenUser.dart';
import 'Routes.dart';

class Navigation{
  // Patró Singleton
  // 1. Creo una instancia privada i estàtica de la classe
  // _internal és el constructor inicial amb nom i privat.
  //     Només s'executa un cop, perque _instance és final
  static final Navigation _instance = Navigation._internal();
  Routes _currentRoute = Routes.login;
  
  // El constructor public retorna la instancia
  // Si ja existeix, doncs la que és,
  // Si no existeix fa s'executa la línia static final UserDB...
  factory Navigation() {
    return _instance;
  }

  // El amb nom constructor inicial privat
  Navigation._internal(){
  }

  // Això és un getter public de la variable privada.
  Routes get currentroute => _currentRoute;
  
  // En comptes de setter faig servir un metodeDiferent

  void goTo(Routes r){
    print("-------Canviant ruta------");
    _currentRoute = r;
  }


  void start() {
    print("--- App Iniciada ---");

    // Loop infinit fins estat de sortir.
    while (_currentRoute != Routes.exit) {
      Screen nextScreen;

      switch(currentroute){
        case Routes.login:
          nextScreen = ScreenLogin();
          break;
        case Routes.user:
          nextScreen = ScreenUser();
          break;
        case Routes.game:
          nextScreen = ScreenGame();
          break;
        default:
          nextScreen = ScreenLogin();
      }
      _currentRoute = nextScreen.show();
    }
  }
}