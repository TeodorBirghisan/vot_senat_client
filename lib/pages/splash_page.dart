import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vot_senat_client/bloc/user_bloc/user_bloc.dart';
import 'package:vot_senat_client/bloc/user_bloc/user_event.dart';
import 'package:vot_senat_client/bloc/user_bloc/user_state.dart';
import 'package:vot_senat_client/handlers/shared_pref_handler.dart';
import 'package:vot_senat_client/widgets/login/login_form.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await SharedPrefHandler.instance.ensureInitialized();

      if (SharedPrefHandler.instance.token != null) {
        BlocProvider.of<UserBloc>(context).add(LoginExistingUser());
        return;
      }

      Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'VOT SENAT UNITBV',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
