import 'dart:io';
import '../navigation/Navigation.dart';
import '../navigation/Routes.dart';
import 'Screen.dart';

// --- VIEW 1: LOGIN ---
class ScreenUser extends Screen {

  @override
  Routes show() {
    bool StayInLoop = true;
    Routes rOut = Navigation().currentroute;
    while (StayInLoop) {
      print("\n--- USER SCREEN ---");
      print("0. Exit \n 1. Login (Refresh) \n 2. User \n 3. Game \n 4. Where am I?");
      stdout.write("Choose option: ");
      
      String? input = stdin.readLineSync();
      switch (input){
        case '0': {
            print("Has seleccionat: Exit");
            StayInLoop = false;
            return Routes.exit;
          }
        case '1': {
            print("Has seleccionat: Login");
            StayInLoop = false;
            return Routes.login;
          }
        case '2': {
          print("Has seleccionat: User");
          StayInLoop = false;
          return Routes.user;
          }
        case '3': {
          print("Has seleccionat: Exit");
          StayInLoop = false;
          return Routes.game;
        }
        case '4': {
          print("Ara estàs a USER");
        }
        default : {
          print("Opció invàlida");
        }
      }
    }
    return rOut;
  }
}