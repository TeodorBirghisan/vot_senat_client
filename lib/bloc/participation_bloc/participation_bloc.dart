import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:vot_senat_client/bloc/participation_bloc/participation_event.dart';
import 'package:vot_senat_client/bloc/participation_bloc/participation_state.dart';
import 'package:vot_senat_client/service/meetings_service.dart';

class ParticipationBloc extends Bloc<ParticipationEvent, ParticipationState> {
  ParticipationBloc() : super(ParticipationInit()) {
    on<JoinMeeting>(_joinMeeting);
    on<ExitMeeting>(_exitMeeting);
  }

  FutureOr<void> _joinMeeting(JoinMeeting event, Emitter emit) async {
    Response response = await MeetingsService.instance.joinMeeting(event.meeting.id!);
    emit(ParticipationLoading());

    if (response.statusCode == HttpStatus.created) {
      emit(ParticipationSuccess(event.meeting));
    } else {
      emit(ParticipationError());
    }
  }

  FutureOr<void> _exitMeeting(ExitMeeting event, Emitter<ParticipationState> emit) async {
    await MeetingsService.instance.exitMeeting(event.meeting.id!);
  }
}
