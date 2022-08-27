import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vot_senat_client/bloc/user_bloc/user_bloc.dart';
import 'package:vot_senat_client/bloc/user_bloc/user_event.dart';
import 'package:vot_senat_client/utils/form_field_data.dart';
import 'package:vot_senat_client/utils/form_validators.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late List<FormFieldData> fields;
  late Map<String, TextEditingController> controllers;

  @override
  void initState() {
    fields = [
      FormFieldData(
        dataKey: "email",
        label: "Email",
        hintText: "",
        validator: FormValidators.notEmptyValidator,
      ),
      FormFieldData(
        dataKey: "password",
        label: "Parola",
        hintText: "",
        validator: FormValidators.notEmptyValidator,
        isPassword: true,
      ),
    ];
    controllers = {};
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          if (null != fields)
            ...fields.map((field) {
              var controller = controllers.putIfAbsent(
                field.dataKey,
                () {
                  return TextEditingController();
                },
              );
              return Column(
                children: [
                  Text(field.label),
                  const SizedBox(height: 4),
                  TextFormField(
                    controller: controller,
                    validator: field.validator,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: field.hintText,
                    ),
                    obscureText: field.isPassword ?? false,
                  ),
                  const SizedBox(height: 32),
                ],
              );
            }),
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
                    BlocProvider.of<UserBloc>(context).add(LoginUser(
                      controllers['email']!.text,
                      controllers['password']!.text,
                    ));
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
