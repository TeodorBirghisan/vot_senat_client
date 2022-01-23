import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'edit_meeting_form.dart';

class CreateMeetingDialog extends StatefulWidget {
  // final Meeting? order;

  const CreateMeetingDialog({
    Key? key,
    // this.order,
  }) : super(key: key);

  @override
  State<CreateMeetingDialog> createState() => _CreateMeetingDialogState();
}

class _CreateMeetingDialogState extends State<CreateMeetingDialog> {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Scaffold(
        appBar: AppBar(
          // title: Text(widget.metting != null ? "Edit Meeting" : "Add Meeting"),
          title: const Text("Add Meeting"),
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            // child: EditMeetingForm(metting: widget.metting),
            child: EditMeetingForm(),
          ),
        ),
      ),
    );
  }
}
