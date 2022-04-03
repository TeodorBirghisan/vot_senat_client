import 'package:vot_senat_client/model/meeting.dart';

abstract class ParticipantsEvent {
  const ParticipantsEvent();
}

class ParticipantsGetAll extends ParticipantsEvent {
  final Meeting meeting;

  ParticipantsGetAll(this.meeting);
}
