import 'model/UserDB.dart';
import 'navigation/Navigation.dart';
import 'navigation/Routes.dart';

void main() {
  final UserDB userDB = UserDB();
  final Navigation navApp = Navigation();
  navApp.start();

  var counter = 0;
  while (counter > 10){}
    // Simulació de input d'usuari. 
    counter++;
      
    if (counter % 3 == 1) {
        Navigation().goTo(Routes.game);
    } else if (counter % 3 == 2) {
        Navigation().goTo(Routes.user);
    } else {
        Navigation().goTo(Routes.login);
    }
    Navigation().goTo(Routes.exit);


}