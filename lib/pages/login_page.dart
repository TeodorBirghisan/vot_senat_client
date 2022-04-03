import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vot_senat_client/bloc/invitation_bloc/invitation_bloc.dart';
import 'package:vot_senat_client/bloc/invitation_bloc/invitation_event.dart';
import 'package:vot_senat_client/widgets/login/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Expanded(
              child: LoginForm(),
            ),
            InkWell(
              onTap: () {
                BlocProvider.of<InvitationBloc>(context).add(ResetInvitation());
                Navigator.of(context).pushNamed("/signup-invitation");
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Foloseste invitatie",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
