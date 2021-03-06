import 'package:flutter/material.dart';
import 'package:vot_senat_client/widgets/login/login_input.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const LoginInputFied(
            title: 'Username',
            isPassword: false,
          ),
          const LoginInputFied(
            title: 'Password',
            isPassword: true,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 50),
                  primary: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushNamedAndRemoveUntil(context, "/available-meetings", (route) => false);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Login successfull'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                child: const Text('LOGIN'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
