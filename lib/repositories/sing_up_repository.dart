


abstract class SingUpRepository{

  Future<SingUpResponese> register(SingUpData data);
}

class SingUpData {
  final String name, lastname, email, password;

  SingUpData({
    required this.name,
    required this.lastname,
    required this.email,
    required this.password,
  });
}

class SingUpResponese{
  final String? error;
  final User? user;

  SingUpResponese(this.error, this.user);
}