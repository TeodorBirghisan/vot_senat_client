import 'package:vot_senat_client/model/meeting.dart';

abstract class MeetingsHistoryState {
  const MeetingsHistoryState();
}

class MeetingsHistoryInit extends MeetingsHistoryState {}

abstract class MeetingsHistoryLoading extends MeetingsHistoryState {}

abstract class MeetingsHistorySuccess extends MeetingsHistoryState {}

abstract class MeetingsHistoryError extends MeetingsHistoryState {}

class MeetingsHistoryGetAllLoading extends MeetingsHistoryLoading {}

class MeetingsHistoryGetAllSuccess extends MeetingsHistorySuccess {
  final List<Meeting> data;
  MeetingsHistoryGetAllSuccess(this.data);
}

class MeetingsHistoryGetAllError extends MeetingsHistoryError {}
