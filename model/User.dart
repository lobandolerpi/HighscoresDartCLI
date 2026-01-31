class User{
  final String email;
  String nick;
  String password;

  User({
    required this.email,
    required this.nick,
    required this.password
  });

  @override
  String toString() => 'User(email: $email, nick: $nick)';

}