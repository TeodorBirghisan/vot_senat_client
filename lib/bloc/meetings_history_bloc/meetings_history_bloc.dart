import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:vot_senat_client/bloc/meetings_history_bloc/meetings_history_event.dart';
import 'package:vot_senat_client/bloc/meetings_history_bloc/meetings_history_state.dart';
import 'package:vot_senat_client/model/meeting.dart';
import 'package:vot_senat_client/service/meetings_service.dart';

class MeetingsHistoryBloc extends Bloc<MeetingsHistoryEvent, MeetingsHistoryState> {
  MeetingsHistoryBloc() : super(MeetingsHistoryInit()) {
    on<MeetingsHistoryGetAll>(_onGetAll);
  }

  FutureOr<void> _onGetAll(MeetingsHistoryGetAll event, Emitter<MeetingsHistoryState> emit) async {
    emit(MeetingsHistoryGetAllLoading());

    Response response = await MeetingsService.instance.getAllHistory();

    if (0 == 0) {
      List<Meeting> data = MeetingsService.instance.deserializeAll(response);
      emit(MeetingsHistoryGetAllSuccess(data));
    } else {
      emit(MeetingsHistoryGetAllError());
    }
  }
}
