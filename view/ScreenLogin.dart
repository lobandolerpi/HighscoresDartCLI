import 'dart:io';
import '../model/OptionMenu.dart';
import '../navigation/Navigation.dart';
import '../navigation/Routes.dart';
import '../viewmodels/VM01Login.dart';
import 'AskData.dart';
import 'Screen.dart';

// --- VIEW 1: LOGIN ---
class ScreenLogin extends Screen {
  final VM01Login vm = VM01Login();
  AskData ask = AskData();

  @override
  void show() {
    List<OptionMenu> optionList = vm.getOptions();
    Map<String, OptionMenu> optionsMap = {
      for (var opt in optionList) opt.key.toUpperCase() : opt
    };

    bool stayInThisScreen = true;
    Routes rOut = Navigation().currentRoute;
    while (stayInThisScreen) {
      print("\n--- LOGIN SCREEN ---");
      for (var opt in optionList){
        print("[" + opt.key + "] " + opt.description);
      }
    
      String input = ask.askString("Selecciona una opcio: ").toUpperCase();
      
      if (!optionsMap.containsKey(input)) {
        print("Opció invàlida");
      } else {
        optionsMap[input]!.action();
      }

      if (Navigation().currentRoute != Routes.login){
        stayInThisScreen=false;
      }
    }
    //return rOut;
  }
}