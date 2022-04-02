import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vot_senat_client/bloc/invitation_bloc/invitation_bloc.dart';
import 'package:vot_senat_client/bloc/invitation_bloc/invitation_event.dart';
import 'package:vot_senat_client/bloc/invitation_bloc/invitation_state.dart';
import 'package:vot_senat_client/utils/form_field_data.dart';
import 'package:vot_senat_client/utils/form_validators.dart';

class InvitationPage extends StatelessWidget {
  const InvitationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invita'),
      ),
      body: BlocBuilder<InvitationBloc, InvitationState>(
        builder: (_, invitationState) {
          if (invitationState is InvitationInit) {
            return InvitationForm();
          }

          if (invitationState is InvitationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (invitationState is InvitationSuccess) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Invitatia a fost trimisa cu success"),
                  const SizedBox(height: 16),
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.greenAccent,
                    size: Theme.of(context).textTheme.headline3!.fontSize,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(300, 50),
                      primary: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      BlocProvider.of<InvitationBloc>(context).add(ResetInvitation());
                    },
                    child: const Text('Invita inca o persoana'),
                  ),
                ],
              ),
            );
          }

          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Invitatia nu a putut fi trimisa"),
                const SizedBox(height: 16),
                Icon(
                  Icons.warning_amber_sharp,
                  color: Colors.redAccent,
                  size: Theme.of(context).textTheme.headline3!.fontSize,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300, 50),
                    primary: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    BlocProvider.of<InvitationBloc>(context).add(ResetInvitation());
                  },
                  child: const Text('Reincearca'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class InvitationForm extends StatefulWidget {
  const InvitationForm({Key? key}) : super(key: key);

  @override
  State<InvitationForm> createState() => _InvitationFormState();
}

class _InvitationFormState extends State<InvitationForm> {
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
                  const SizedBox(height: 8),
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
                    BlocProvider.of<InvitationBloc>(context).add(
                      InviteUser(controllers['email']!.text),
                    );
                  }
                },
                child: const Text('INVITE'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
