import 'package:vot_senat_client/model/meeting.dart';

abstract class ParticipationState {
  const ParticipationState();
}

class ParticipationInit extends ParticipationState {}

class ParticipationLoading extends ParticipationState {}

class ParticipationSuccess extends ParticipationState {
  final Meeting meeting;

  ParticipationSuccess(this.meeting);
}

class ParticipationError extends ParticipationState {}
