import 'dart:io';
import '../model/User.dart';
import '../navigation/Navigation.dart';
import '../navigation/Routes.dart';
import 'Screen.dart';

// --- VIEW 1: LOGIN ---
class ScreenUser extends Screen {
  User? currentUser = Navigation().currentUser;

  @override
  void show() {
    if (currentUser == null) {
      print("BUG: Hauria d'haver un usuari aqui");
      Navigation().goTo(Routes.login);
    } else {
      User cU = currentUser as User;
      bool StayInLoop = true;
      Routes rOut = Navigation().currentRoute;
      while (StayInLoop) {
        print("\n--- USER " + cU.email + " SCREEN ---");
        print(
          "0. Exit \n 1. Login (Refresh) \n 2. User \n 3. Game \n 4. Where am I?",
        );
        stdout.write("Choose option: ");

        String? input = stdin.readLineSync();
        switch (input) {
          case '0':
            {
              print("Has seleccionat: Exit");
              StayInLoop = false;
              Navigation().goTo(Routes.exit);
              return;
            }
          case '1':
            {
              print("Has seleccionat: Login");
              StayInLoop = false;
              Navigation().goTo(Routes.login);
              return;
            }
          case '2':
            {
              print("Has seleccionat: User");
              StayInLoop = false;
              Navigation().goTo(Routes.user);
              return;
            }
          case '3':
            {
              print("Has seleccionat: Exit");
              StayInLoop = false;
              Navigation().goTo(Routes.game);
              return;
            }
          case '4':
            {
              print("Ara estàs a USER");
            }
          default:
            {
              print("Opció invàlida");
            }
        }
      }
    }

    return;
  }
}
