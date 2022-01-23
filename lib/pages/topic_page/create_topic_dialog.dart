import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vot_senat_client/model/meeting.dart';

import 'edit_topic_form.dart';

class CreateTopicDialog extends StatefulWidget {
  // final Topic? order;
  final Meeting meeting;

  const CreateTopicDialog({
    Key? key,
    required this.meeting,
    // this.order,
  }) : super(key: key);

  @override
  State<CreateTopicDialog> createState() => _CreateTopicDialogState();
}

class _CreateTopicDialogState extends State<CreateTopicDialog> {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Scaffold(
        appBar: AppBar(
          // title: Text(widget.metting != null ? "Edit Topic" : "Add Topic"),
          title: const Text("Add Topic"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            // child: EditTopicForm(metting: widget.metting),
            child: EditTopicForm(meeting: widget.meeting),
          ),
        ),
      ),
    );
  }
}
