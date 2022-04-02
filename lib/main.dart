import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vot_senat_client/bloc/meetings_history_bloc/meetings_history_bloc.dart';
import 'package:vot_senat_client/bloc/topic_bloc/topic_bloc.dart';
import 'package:vot_senat_client/bloc/user_bloc/user_bloc.dart';
import 'package:vot_senat_client/bloc/user_bloc/user_event.dart';
import 'package:vot_senat_client/handlers/navigator_handler.dart';
import 'package:vot_senat_client/pages/available_meetings/available_meetings_page.dart';
import 'package:vot_senat_client/pages/login_page.dart';
import 'package:vot_senat_client/pages/splash_page.dart';

import 'bloc/meetings_bloc/meetings_bloc.dart';
import 'bloc/todo_bloc/todo_bloc.dart';
import 'bloc/user_bloc/user_state.dart';
import 'handlers/shared_pref_handler.dart';

void main() async {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MeetingsBloc>(
          create: (BuildContext context) => MeetingsBloc(),
        ),
        BlocProvider<TopicBloc>(
          create: (BuildContext context) => TopicBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => MeetingsHistoryBloc(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<UserBloc, UserState>(
            listener: _handleUserListener,
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          navigatorKey: NavigatorHandler.instance.navigatorKey,
          initialRoute: "/splash",
          routes: {
            "/available-meetings": (BuildContext context) => const AvailableMeetingsPage(),
            "/login": (BuildContext context) => const LoginPage(),
            "/splash": (BuildContext context) => SplashPage(),
          },
        ),
      ),
    );
  }

  void _handleUserListener(context, userState) async {
    if (userState is UserNotAuthenticated) {
      NavigatorHandler.instance.pushNamedAndRemoveUntil('/login', (_) => false);
    }

    if (userState is UserAuthenticated) {
      NavigatorHandler.instance.pushNamedAndRemoveUntil("/available-meetings", (route) => false);
    }
  }
}
