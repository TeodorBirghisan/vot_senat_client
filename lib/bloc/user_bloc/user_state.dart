abstract class UserState {
  const UserState();
}

class UserInit extends UserState {}

abstract class UserLoading extends UserState {}

class UserAuthenticated extends UserState {}

class UserNotAuthenticated extends UserState {}
