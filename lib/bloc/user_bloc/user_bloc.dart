import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:vot_senat_client/handlers/shared_pref_handler.dart';
import 'package:vot_senat_client/service/user_service.dart';

import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInit()) {
    on<LoginUser>(_onLogin);
    on<LogoutUser>(_onLogout);
    on<LoginExistingUser>(_onLoginExistingUser);
  }

  FutureOr<void> _onLogin(LoginUser event, Emitter<UserState> emit) async {
    Response response = await UserService.instance.login(event.email, event.password);

    if (response.statusCode == HttpStatus.created) {
      var jsonBody = json.decode(response.body);
      SharedPrefHandler.instance.token = jsonBody['accessToken'];
      SharedPrefHandler.instance.role = jsonBody['role'];
      SharedPrefHandler.instance.userId = jsonBody['userId'];
      emit(UserAuthenticated());
    } else {
      emit(UserNotAuthenticated());
    }
  }

  FutureOr<void> _onLoginExistingUser(LoginExistingUser event, Emitter<UserState> emit) {
    emit(UserAuthenticated());
  }

  FutureOr<void> _onLogout(LogoutUser event, Emitter<UserState> emit) async {
    SharedPrefHandler.instance.removeToken();
    SharedPrefHandler.instance.removeRole();
    SharedPrefHandler.instance.removeUserId();
    emit(UserNotAuthenticated());
  }
}
