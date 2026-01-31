import '../navigation/Navigation.dart';
import '../navigation/Routes.dart';

class OptionMenu {
  final String letter;
  Function functionToExecute;
  String textToShow;

  OptionMenu({
    required this.letter,
    required this.functionToExecute,
    required this.textToShow
  });

  Routes executeOption(Routes? r) {
    Routes rOut;
    if (r == null){
      rOut = Navigation().currentroute;
    } else 
    { rOut = r;}

    functionToExecute();

    return rOut;
  }
}