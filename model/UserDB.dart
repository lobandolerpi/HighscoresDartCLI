import 'User.dart';
import 'dart:io';

class UserDB {
  // Patró Singleton
  // 1. Creo una instancia privada i estàtica de la classe
  // _internal és el constructor inicial amb nom i privat.
  //     Només s'executa un cop, perque _instance és final
  static final UserDB _instance = UserDB._internal();
  final Map<String, User> _users = {};
  final File _file = File("userDB.txt");

  // El constructor public retorna la instancia
  // Si ja existeix, doncs la que és,
  // Si no existeix fa s'executa la línia static final UserDB...
  factory UserDB() {
    return _instance;
  }

  // El amb nom constructor inicial privat
  UserDB._internal(){

    if (!_file.existsSync()) {
      _file.createSync();
      print("Avís: No s'ha trobat 'userDB.txt'. Se n'ha creat un de nou.");
    }

    _loadUsers();
    if (_users.isEmpty){
      addFakeData();
    }
  }




  // " CONSULTES "

  // getter nullable perque potser no existeix
  User? getUser(String email) {
    return _users[email];
  }

  bool addUser(User user) {
    if (_users.containsKey(user.email)) {
      return false; 
    }
    _users[user.email] = user;
    _updateDBtxt();
    return true;
  }

  bool modifyUser(User user) {
    if (_users.containsKey(user.email)) {
      _users[user.email] = user;
      _updateDBtxt();
      return true; 
    }
    return false;
  }

  bool deleteUser(String email) {
    if (_users.containsKey(email)) {
      _users.remove(email);
      _updateDBtxt(); 
      return true;
    }
    return false;
  }


  // FUNCIONS AUXILIARS
  String _userToLine(User u) {
    return "${u.email},${u.nick},${u.password}";
  }

  User? _lineToUser(String l){
    var parts = l.trim().split(',');
    for (String p in parts){
      p.trim();
    }
    // Assumim que el fitxer no té errors.
    if (parts.length== 3 
      && !parts.contains("") 
    ) {
      return User(
        email: parts[0],
        nick: parts[1],
        password: parts[2],
      );
    } else {
      return null;
      }
  }

  // PERSISTENCIA DE LA BD
  void _updateDBtxt() {
    // Creem un buffer per escriure totes les línies
    var buffer = StringBuffer();
    
    for (var user in _users.values) {
      // Excriure la línia de l'usuari + salt de línia
      buffer.writeln(_userToLine(user));
    }

    // Sobreescrivim tot el fitxer amb el nou contingut
    _file.writeAsStringSync(buffer.toString());
  }

  void _loadUsers() {
    if (!_file.existsSync()) return;

    // Llegeix totes les línies del fitxer en una Llista de Strings
    List<String> lines = _file.readAsLinesSync();
    // Loop que afegeix usuari si pot.
    for (var line in lines) {
      User? u = _lineToUser(line);
      if (u != null) {
        _users[u.email] = u;
      }
    }
  }

  void addFakeData(){
    String letters = "abcdefg";
    for( String l in letters.split('')){
      addUser( 
        User(
          email: l+"@"+l+"."+l, 
          nick: l, 
          password: l
        )
      );
    }
  }
}