import 'package:vot_senat_client/model/user.dart';

abstract class ParticipantsState {
  const ParticipantsState();
}

class ParticipantsInit extends ParticipantsState {}

class ParticipantsLoading extends ParticipantsState {}

class ParticipantsGetSuccess extends ParticipantsState {
  final List<User> users;
  ParticipantsGetSuccess(this.users);
}

class ParticipantsGetFailure extends ParticipantsState {
  ParticipantsGetFailure();
}
