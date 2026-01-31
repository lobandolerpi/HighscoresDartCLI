import '../navigation/Navigation.dart';
import '../navigation/Routes.dart';

// Creo un tipus, que és una funció que he de rebre.
// Per consistencia totes sense paràmetres.
// Ja m'apanyaré quan la cridi
typedef MenuAction = void Function();

class OptionMenu {
  final String key;
  final String description;
  final MenuAction action;

  OptionMenu({
    required this.key,
    required this.description,
    required this.action
  });
}