import 'package:vot_senat_client/model/meeting.dart';

abstract class MeetingsState {
  const MeetingsState();
}

class MeetingsInit extends MeetingsState {}

abstract class MeetingsLoading extends MeetingsState {}

abstract class MeetingsSuccess extends MeetingsState {}

abstract class MeetingsError extends MeetingsState {}

class MeetingGetAllLoading extends MeetingsLoading {}

class MeetingGetAllSuccess extends MeetingsSuccess {
  final List<Meeting> data;
  MeetingGetAllSuccess(this.data);
}

class MeetingGetAllError extends MeetingsError {}

class MeetingCreateLoading extends MeetingsLoading {}

class MeetingCreateSuccess extends MeetingsSuccess {
  final Meeting data;
  MeetingCreateSuccess(this.data);
}

class MeetingCreateError extends MeetingsError {}

class MeetingDeleteOneSuccess extends MeetingsSuccess {
  final int meetingId;
  MeetingDeleteOneSuccess(this.meetingId);
}

class MeetingDeleteOneError extends MeetingsError {}

class MeetingDeleteOneLoading extends MeetingsLoading {}
