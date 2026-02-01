import './User.dart';

class Team {
  final List<User> _users =[];
  final int _maxUsers;
  final String teamName;

  Team(
    this._maxUsers,
    this.teamName
  ){
  }

  bool addUser(User u){
    if (_users.contains(u) || _users.length >= _maxUsers){
      return false;
    }
    _users.add(u);
    return true;
  }

  bool removeUser(User u){
    if (_users.contains(u) ){
      _users.remove(u);
      return true;
    }
    return false;
  }

  List<User> get users{
    List<User> l = List.of(_users);
    return l;
  }
}