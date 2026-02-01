import 'dart:math';

import 'AppData.dart';
import 'License.dart';
import 'UserDB.dart';

class User {
  final String email;
  String nick;
  String password;
  final Map<String, License> _licenses = {};
  final Map<String, User> _friends = {};

  User({required this.email, required this.nick, required this.password});

  @override
  String toString() => 'User(email: $email, nick: $nick)';

  void addLicense(License l) {
    _licenses[l.gameName] = l;
  }

  void removeLicense(License l) {
    _licenses.remove(l.gameName);
  }

  List<String> availableGames() {
    List<String> l = [];
    for (String s in _licenses.keys) {
      l.add(s);
    }
    return l;
  }

  List<String> listFriends() {
    List<String> l = [];
    for (String s in _friends.keys) {
      l.add(s);
    }
    return l;
  }

  String? getLicenseNumber(String gameName) {
    License? l = _licenses[gameName];
    if (l == null) {
      return null;
    }
    return l.ID as String?;
  }

  bool addFriend(User friend) {
    if (_friends.containsKey(friend.email)) {
      return false;
    }
    _friends[friend.email] = friend;
    return true;
  }

  bool removeFriend(User friend) {
    if (_friends.containsKey(friend.email)) {
      _friends.remove(friend.email);
      return true;
    }
    return false;
  }

  bool donarJoc(String gameCode, String friendEmail){
    if(!_friends.containsKey(friendEmail)
    || !_licenses.containsKey(gameCode))
    {
      return false;
    }
    User? friend = UserDB().getUser(friendEmail);
    if (friend == null) {
      return false; 
    }
    License l = _licenses[gameCode] as License;
    if (l.numChanges > 0){
      l.numChanges -= 1;
      friend.addLicense(l);
      removeLicense(l);
      return true;
    }
    return false;
  }

  List<String> llistarJocsDonables(){
    List<String> list =[];
    for (var entry in _licenses.entries){
      License l = entry.value;
      if (l.numChanges > 0) {
        list.add(l.gameName);
      }
    }
    return list;
  }
}
