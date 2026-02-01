import 'dart:io';

import '../utils/Utils.dart';

class AskData {
  String askString(String question){
    String? inUsrTxt;
    do {
      print(question);
      inUsrTxt = stdin.readLineSync();
      if (inUsrTxt == null) {
        print("ERROR: Has d'escriute quelcom.");
      }
    } while (inUsrTxt == null);
    return inUsrTxt ;
  }

  String askStringNoCharacter(String question, List<String> noAllowed){
    bool accept = false;
    String inUsrTxt = "kk";
    while (!accept){
      inUsrTxt = askString(question);
      accept = true;
      for (String s in noAllowed){
        if (inUsrTxt.contains(s)){
          accept = false;
          break;
        }
      }
    }
    return inUsrTxt ;
  }


  String askStringInList(String question, List<String> allowed){
    bool accept = false;
    String inUsrTxt = "kk";
    while (!accept){
      inUsrTxt = askString(question);
      if (!allowed.contains(inUsrTxt.toUpperCase()) 
      &&  !allowed.contains(inUsrTxt.toLowerCase()) ) 
      {
        print("Opció no vàlida, torna-ho a intentar.");
      } else {
        accept = true;
      }
    }
    return inUsrTxt ;
  }

  String askEmail(String question){
    String inUsrTxt = askStringNoCharacter(question, [",",";","|"]);
    while(!inUsrTxt.isValidEmail()){
      print("No és un e-mail valid");
      inUsrTxt = askStringNoCharacter(question, [",",";","|"]);
    }
    return inUsrTxt;
  }

  void printList(List<String> l){
    for (String s in l){
      print(s);
    }
  }
}