class UserStateModel {
  UserStateModel({
    required this.email,
    required this.firstName,
    this.surname
  });

  final String email;
  final String firstName;
  final String? surname;

  static UserStateModel empty() {
    return UserStateModel(email: '', firstName: '');
  }
}