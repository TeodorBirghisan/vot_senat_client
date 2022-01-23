import 'package:vot_senat_client/model/meeting.dart';

abstract class MeetingsEvent {
  const MeetingsEvent();
}

class MeetingsGetAll extends MeetingsEvent {}

class MeetingsCreate extends MeetingsEvent {
  Meeting data;
  MeetingsCreate(this.data);
}
