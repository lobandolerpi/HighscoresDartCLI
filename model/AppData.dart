import 'dart:math';

import 'Games/Game.dart';
import 'Games/GameType.dart';
import 'License.dart';
import 'User.dart';
import 'dart:io';

import 'UserDB.dart';

class AppData {
  // Patró Singleton
  // 1. Creo una instancia privada i estàtica de la classe
  // _internal és el constructor inicial amb nom i privat.
  //     Només s'executa un cop, perque _instance és final
  static final AppData _instance = AppData._internal();
  final Map<String, Game> _games = {};

  // El constructor public retorna la instancia
  // Si ja existeix, doncs la que és,
  // Si no existeix fa s'executa la línia static final UserDB...
  factory AppData() {
    return _instance;
  }

  // El amb nom constructor inicial privat
  AppData._internal(){
    addGamesData();
  }




  // " CONSULTES "

  // getter nullable perque potser no existeix
  Game? getGame(String codi) {
    return _games[codi];
  }

  bool addGame(Game g) {
    if (_games.containsKey(g.code)) {
      return false; 
    }
    _games[g.code] = g;
    return true;
  }

  bool deleteGame(String code) {
    if (_games.containsKey(code)) {
      _games.remove(code);
      return true;
    }
    return false;
  }
  

  void addGamesData(){
    List<User> auxFixedUserList =[];
    String auxLet = "abcdefg";
    String email = "";
    for( String l in auxLet.split('')){
      email= l+"@"+l+"."+l;
      User? u = UserDB().getUser(email);
      if (u!= null){
        auxFixedUserList.add(u);
      }
    }
    _games["mario"] = GamePunts(name: "Mario", code: "mario", preuCompra: 20, preuLloguer: 10, type: GameTypes.plataformes);
    _games["sonic"] = GamePunts(name: "Sonic", code: "sonic", preuCompra: 20, preuLloguer: 10, type: GameTypes.plataformes);
    _games["rmg"] = GamePunts(name: "Remigio", code: "rmg", preuCompra: 20, preuLloguer: 10, type: GameTypes.cartes);
    _games["sols"] = GameSpeedRun(name: "Solitari Spider", code: "sols", preuCompra: 20, preuLloguer: 10, type: GameTypes.cartes);
    _games["soln"] = GameSpeedRun(name: "Solitari Normal", code: "soln", preuCompra: 20, preuLloguer: 10, type: GameTypes.cartes);
    _games["f1"] = GamePunts(name: "Formula 1", code: "f1", preuCompra: 20, preuLloguer: 10, type: GameTypes.simulacio);
    _games["mma"] = GameWL(name: "Mixed Martial Arts", code: "mma", preuCompra: 20, preuLloguer: 10, type: GameTypes.simulacio);
    _games["box"] = GameWL(name: "Boxing", code: "box", preuCompra: 20, preuLloguer: 10, type: GameTypes.simulacio);
    _games["cod"] = GamePuntsCoop(name: "Call of Duty", code: "cod", preuCompra: 20, preuLloguer: 10, type: GameTypes.shooter);
    _games["bdl"] = GamePuntsCoop(name: "Borderlands", code: "bdl", preuCompra: 20, preuLloguer: 10, type: GameTypes.shooter);
    
    Random rand = Random();
    List<int> listInt =[];
    int max = auxFixedUserList.length;
    for (int i=0; i<max; i++){
      listInt.add(i);
    }
    for (var entry in _games.entries){ // per cada joc
      List<User> auxUserList = List.of(auxFixedUserList); // copio lista usuaris
      Game g = entry.value; // agafo el joc
      List<String> licenseTypes = ["C", "L", "P"];
      for (int i=0; i< max/2; i++){
        // trec usuaris aleatoris (maxim la meitat)
        if (auxUserList.length>0){
        auxUserList.remove(rand.nextInt(auxUserList.length));
        }
      }
      for (User u in auxUserList){
        String lT = licenseTypes[rand.nextInt(licenseTypes.length)];
        License l = g.generateSpecificLicence(lT);
        u.addLicense(l);
      }
    }
  }
}