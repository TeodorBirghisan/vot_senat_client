import 'package:flutter/material.dart';
import 'package:vot_senat_client/widgets/signup/signup_input.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              SignupInputField(
                title: 'first Name',
                fieldWidth: 170, //MediaQuery.of(context).size.width / 4,
                inputIcon: Icon(
                  Icons.account_circle_rounded,
                  color: Colors.black87,
                ),
              ),
              SignupInputField(
                title: 'last Name',
                fieldWidth: 170, //MediaQuery.of(context).size.width / 4,
                inputIcon: Icon(
                  Icons.account_circle_rounded,
                  color: Colors.black87,
                ),
              )
            ],
          ),
          const SignupInputField(
            title: 'email',
            fieldWidth: 350,
            inputIcon: Icon(
              Icons.account_circle_rounded,
              color: Colors.black87,
            ),
          ),
          const SignupInputField(
            title: 'password',
            fieldWidth: 350,
            isPassword: true,
            inputIcon: Icon(
              Icons.security,
              color: Colors.black87,
            ),
          ),
          const SignupInputField(
            title: 'confirm password',
            fieldWidth: 350,
            isPassword: true,
            inputIcon: Icon(
              Icons.security,
              color: Colors.black87,
            ),
          ),
          const SignupInputField(
            title: 'phone number',
            fieldWidth: 350,
            inputIcon: Icon(
              Icons.phone,
              color: Colors.black87,
            ),
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Login in progress'),
                      ),
                    );
                  }
                },
                child: const Text('Sign up'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
