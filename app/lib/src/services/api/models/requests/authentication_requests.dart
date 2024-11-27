class RegisterUserRequest {
  const RegisterUserRequest({
    required this.email,
    required this.password,
    required this.firstName,
    this.surname,
  });

  final String email;
  final String password;
  final String firstName;
  final String? surname;

  toJsonMap() {
    return {
      'email': email,
      'password': password,
      'firstName': firstName,
      'surname': surname,
    };
  }
}