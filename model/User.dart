import 'License.dart';

class User{
  final String email;
  String nick;
  String password;
  Map<String, License> _licenses = {};

  User({
    required this.email,
    required this.nick,
    required this.password
  });

  @override
  String toString() => 'User(email: $email, nick: $nick)';

  void addLicense(License l){
    _licenses[l.gameName] = l;
  }
}