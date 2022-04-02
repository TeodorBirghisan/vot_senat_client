abstract class UserEvent {
  const UserEvent();
}

class LoginUser extends UserEvent {
  final String email;
  final String password;

  LoginUser(this.email, this.password);
}

class LoginExistingUser extends UserEvent {}

class LogoutUser extends UserEvent {}
