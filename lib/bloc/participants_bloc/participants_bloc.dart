import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:vot_senat_client/bloc/participants_bloc/participants_event.dart';
import 'package:vot_senat_client/bloc/participants_bloc/participants_state.dart';
import 'package:vot_senat_client/model/user.dart';
import 'package:vot_senat_client/service/meetings_service.dart';
import 'package:vot_senat_client/service/user_service.dart';

class ParticipantsBloc extends Bloc<ParticipantsEvent, ParticipantsState> {
  ParticipantsBloc() : super(ParticipantsInit()) {
    on<ParticipantsGetAll>(_onGetAll);
  }

  FutureOr<void> _onGetAll(ParticipantsGetAll event, Emitter<ParticipantsState> emit) async {
    emit(ParticipantsLoading());

    Response response = await MeetingsService.instance.getParticipants(event.meeting.id!);

    if (response.statusCode == HttpStatus.ok) {
      List<User> users = UserService.instance.deserializeAll(response);
      emit(ParticipantsGetSuccess(users));
    } else {
      emit(ParticipantsGetFailure());
    }
  }
}
