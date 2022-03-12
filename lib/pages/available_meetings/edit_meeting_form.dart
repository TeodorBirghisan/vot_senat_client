import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:vot_senat_client/bloc/meetings_bloc/meetings_bloc.dart';
import 'package:vot_senat_client/bloc/meetings_bloc/meetings_event.dart';
import 'package:vot_senat_client/model/meeting.dart';
import 'package:vot_senat_client/utils/form_field_data.dart';
import 'package:vot_senat_client/utils/form_validators.dart';

class EditMeetingForm extends StatefulWidget {
  // final Meeting? data;

  const EditMeetingForm({
    Key? key,
    // this.data,
  }) : super(key: key);

  @override
  State<EditMeetingForm> createState() => _EditMeetingFormState();
}

class _EditMeetingFormState extends State<EditMeetingForm> {
  final _formKey = GlobalKey<FormState>();
  late List<FormFieldData> fields;
  late Map<String, TextEditingController> controllers;
  late DateTime startDate;

  @override
  void initState() {
    super.initState();

    fields = [
      FormFieldData(
        dataKey: "title",
        label: "Title",
        hintText: "",
        validator: FormValidators.notEmptyValidator,
      ),
      FormFieldData(
        dataKey: "description",
        label: "Description",
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
      child: Center(
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            children: [
              const SizedBox(height: 10),
              if (null != fields)
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
                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(field.label),
                      const SizedBox(height: 10),
                      Container(
                        width: constraints.maxWidth < 450 ? constraints.maxWidth * 0.8 : constraints.maxWidth * 0.6,
                        child: Center(
                          child: TextFormField(
                            controller: controller,
                            validator: field.validator,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: field.hintText,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                }),
              const SizedBox(height: 8),
              Container(
                width: constraints.maxWidth < 450 ? constraints.maxWidth * 0.8 : constraints.maxWidth * 0.4,
                child: Align(
                  alignment: Alignment.center,
                  child: DateTimePicker(
                    type: DateTimePickerType.dateTime,
                    initialValue: '',
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    dateLabelText: 'Start Time',
                    validator: (val) {},
                    onChanged: (val) {
                      setState(() {
                        startDate = DateTime.parse(val);
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 38),
              ElevatedButton(
                onPressed: () {
                  //TODO check if startDate is added
                  if (_formKey.currentState!.validate()) {
                    Map<String, String> result = {
                      for (MapEntry<String, TextEditingController> entry in controllers.entries) entry.key: entry.value.text,
                    };
                    Meeting formData = Meeting.fromJson(result);
                    formData.startDate = startDate;
                    // if (widget.order != null) {
                    //   formData.id = widget.order!.id;
                    // }

                    // MeetingEvent event = widget.order != null ? UpdateMeeting(formData) : CreateMeeting(formData);
                    MeetingsEvent event = MeetingsCreate(formData);
                    context.read<MeetingsBloc>().add(event);

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
          );
        }),
      ),
    );
  }
}
