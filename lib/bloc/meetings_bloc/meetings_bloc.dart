import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:vot_senat_client/model/meeting.dart';
import 'package:vot_senat_client/service/meetings_service.dart';

import 'meetings_event.dart';
import 'meetings_state.dart';

class MeetingsBloc extends Bloc<MeetingsEvent, MeetingsState> {
  MeetingsBloc() : super(MeetingsInit()) {
    on<MeetingsGetAll>(_onGetAll);
    on<MeetingsCreate>(_onCreate);
  }

  FutureOr<void> _onGetAll(MeetingsGetAll event, Emitter<MeetingsState> emit) async {
    emit(MeetingGetAllLoading());

    Response response = await MeetingsService.instance.getAll();

    if (response.statusCode == HttpStatus.ok) {
      List<Meeting> data = MeetingsService.instance.deserializeAll(response);
      emit(MeetingGetAllSuccess(data));
    } else {
      emit(MeetingGetAllError());
    }
    //TODO check response for 401 and logout user in case this is emited
  }

  FutureOr<void> _onCreate(MeetingsCreate event, Emitter<MeetingsState> emit) async {
    emit(MeetingCreateLoading());

    Response response = await MeetingsService.instance.create(event.data);

    if (response.statusCode == HttpStatus.created) {
      Meeting data = MeetingsService.instance.deserializeOne(response);
      emit(MeetingCreateSuccess(data));
    } else {
      emit(MeetingGetAllError());
    }
  }
}
