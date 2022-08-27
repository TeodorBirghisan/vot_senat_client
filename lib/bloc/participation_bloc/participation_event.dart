import 'package:vot_senat_client/model/meeting.dart';

abstract class ParticipationEvent {}

class JoinMeeting extends ParticipationEvent {
  final Meeting meeting;

  JoinMeeting(this.meeting);
}

class ExitMeeting extends ParticipationEvent {
  final Meeting meeting;

  ExitMeeting(this.meeting);
}
