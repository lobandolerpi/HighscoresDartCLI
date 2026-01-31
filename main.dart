import 'model/UserDB.dart';
import 'navigation/Navigation.dart';
import 'navigation/Routes.dart';

void main() {
  final UserDB userDB = UserDB();
  final Navigation navApp = Navigation();
  navApp.start();



}