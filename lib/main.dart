import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vot_senat_client/bloc/todo_bloc/todo_bloc.dart';
import 'package:vot_senat_client/bloc/topic_bloc/topic_bloc.dart';
import 'package:vot_senat_client/pages/available_meetings/available_meetings_page.dart';
import 'package:vot_senat_client/pages/login_page.dart';

import 'bloc/meetings_bloc/meetings_bloc.dart';

void main() async {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => TodoBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => MeetingsBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => TopicBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/available-meetings",
        routes: {
          "/available-meetings": (BuildContext context) => const AvailableMeetingsPage(),
          "/login": (BuildContext context) => const LoginPage(),
        },
      ),
    );
  }
}
