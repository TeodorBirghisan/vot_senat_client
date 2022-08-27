abstract class InvitationEvent {}

class InviteUser extends InvitationEvent {
  final String email;

  InviteUser(this.email);
}

class ResetInvitation extends InvitationEvent {}

class SignupUserInvitation extends InvitationEvent {
  final String email;
  final String password;
  final String invitationCode;

  SignupUserInvitation(this.email, this.password, this.invitationCode);
}
