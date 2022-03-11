import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:vot_senat_client/bloc/topic_bloc/topic_bloc.dart';
import 'package:vot_senat_client/bloc/topic_bloc/topic_event.dart';
import 'package:vot_senat_client/model/meeting.dart';
import 'package:vot_senat_client/model/topic.dart';
import 'package:vot_senat_client/utils/form_field_data.dart';
import 'package:vot_senat_client/utils/form_validators.dart';

class EditTopicForm extends StatefulWidget {
  // final Topic? data;
  final Meeting meeting;

  const EditTopicForm({
    Key? key,
    required this.meeting,
    // this.data,
  }) : super(key: key);

  @override
  State<EditTopicForm> createState() => _EditTopicFormState();
}

class _EditTopicFormState extends State<EditTopicForm> {
  final _formKey = GlobalKey<FormState>();
  late List<FormFieldData> fields;
  late Map<String, TextEditingController> controllers;
  late DateTime startDate;

  @override
  void initState() {
    super.initState();

    fields = [
      FormFieldData(
        dataKey: "content",
        label: "Topic Content",
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
        children: [
          const SizedBox(height: 32),
          if (fields != null)
            ...fields.map((field) {
              var controller = controllers.putIfAbsent(
                field.dataKey,
                () {
                  // if (widget.meeting != null) {
                  //   Map<String, dynamic> json = widget.order!.toJson();
                  //   return TextEditingController.fromValue(
                  //     TextEditingValue(
                  //       text: json[field.dataKey],
                  //     ),
                  //   );
                  // }

                  return TextEditingController();
                },
              );
              return Center(
                child: LayoutBuilder(
                  builder: (context, constraints) => Column(
                    children: [
                      Text(field.label),
                      const SizedBox(height: 4),
                      Container(
                        width: constraints.maxWidth < 450 ? constraints.maxWidth * 0.8 : constraints.maxWidth * 0.6,
                        child: TextFormField(
                          controller: controller,
                          validator: field.validator,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: field.hintText,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            }),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              //TODO check if startDate is added
              if (_formKey.currentState!.validate()) {
                Map<String, String> result = {
                  for (MapEntry<String, TextEditingController> entry in controllers.entries) entry.key: entry.value.text,
                };
                Topic formData = Topic.fromJson(result);
                // if (widget.order != null) {
                //   formData.id = widget.order!.id;
                // }

                // TopicEvent event = widget.order != null ? UpdateTopic(formData) : CreateTopic(formData);
                TopicEvent event = TopicCreate(formData, widget.meeting);
                context.read<TopicBloc>().add(event);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Processing Data'),
                  ),
                );
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('Error Saving Data'),
                  ),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
