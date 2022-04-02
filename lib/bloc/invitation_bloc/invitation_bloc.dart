import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:vot_senat_client/bloc/invitation_bloc/invitation_event.dart';
import 'package:vot_senat_client/bloc/invitation_bloc/invitation_state.dart';
import 'package:vot_senat_client/bloc/user_bloc/user_event.dart';
import 'package:vot_senat_client/service/invitation_sevice.dart';

class InvitationBloc extends Bloc<InvitationEvent, InvitationState> {
  InvitationBloc() : super(InvitationInit()) {
    on<InviteUser>(_invite);
    on<ResetInvitation>(_reset);
    on<SignupUserInvitation>(_onSignupUserInvitation);
  }

  FutureOr<void> _invite(
      InviteUser event, Emitter<InvitationState> emit) async {
    emit(InvitationLoading());

    Response response = await InvitationService.instance.invite(event.email);

    if (response.statusCode == HttpStatus.created) {
      emit(InvitationSuccess());
    } else {
      emit(InvitationError());
    }
  }

  FutureOr<void> _reset(
      ResetInvitation event, Emitter<InvitationState> emit) async {
    emit(InvitationInit());
  }

  FutureOr<void> _onSignupUserInvitation(
      SignupUserInvitation event, Emitter<InvitationState> emit) async {
    emit(InvitationLoading());

    Response response = await InvitationService.instance
        .signUpInvitation(event.email, event.password, event.invitationCode);

    if (response.statusCode == HttpStatus.created) {
      emit(InvitationSignupSuccess());
    } else {
      emit(InvitationSignupError());
    }
  }
}
