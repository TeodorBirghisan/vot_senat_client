import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:provider/src/provider.dart';
import 'package:vot_senat_client/bloc/meetings_bloc/meetings_bloc.dart';
import 'package:vot_senat_client/bloc/meetings_bloc/meetings_event.dart';
import 'package:vot_senat_client/bloc/participation_bloc/participation_bloc.dart';
import 'package:vot_senat_client/bloc/participation_bloc/participation_event.dart';
import 'package:vot_senat_client/model/meeting.dart';
import 'package:vot_senat_client/pages/topic_page/topic_page.dart';
import 'package:intl/intl.dart';
import 'package:vot_senat_client/service/meetings_service.dart';

class MeetingCard extends StatefulWidget {
  final Meeting meeting;

  const MeetingCard({
    Key? key,
    required this.meeting,
  }) : super(key: key);

  @override
  State<MeetingCard> createState() => _MeetingCardState();
}

class _MeetingCardState extends State<MeetingCard> {
  late bool _isOverdue;

  @override
  void initState() {
    super.initState();
    DateTime startDate = widget.meeting.startDate ?? DateTime.now();
    _isOverdue = startDate.difference(DateTime.now()).inMinutes <= 0;
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      shadowColor: Colors.grey,
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Wrap(
                      children: [
                        Text(
                          widget.meeting.title ?? "",
                          style: Theme.of(context).textTheme.subtitle2,
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                  ),
                  Material(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(24),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text('Delete ${widget.meeting.title} ?'),
                          content: const Text('Are you sure you want to delete?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                MeetingsEvent event = MeetingsDeleteOne(widget.meeting.id!);
                                context.read<MeetingsBloc>().add(event);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text('Processing Data'),
                                  ),
                                );
                                Navigator.pop(context, 'OK');
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.schedule,
                    color: Colors.black,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  _buildTimeText(widget.meeting.startDate),
                ],
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isOverdue && widget.meeting.status != "FINISHED")
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            BlocProvider.of<ParticipationBloc>(context).add(JoinMeeting(widget.meeting));
                          },
                          child: const Text('Participă'),
                        ),
                      ],
                    ),
                  ),

                //TODO hide to some users
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.greenAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TopicPage(
                                meeting: widget.meeting,
                                isEditMode: true,
                              ),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Text('Creeaza topicuri'),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String _computeRemainingTime(DateTime startDate) {
    Duration remainingTime = startDate.difference(DateTime.now());
    int hours = remainingTime.inHours;
    int minutes = remainingTime.inMinutes % 60;

    if (hours < 1) {
      return "Incepe in $minutes minute";
    }
    return "Incepe in $hours ore si $minutes minute ";
  }

  Widget _buildTimeText(DateTime? startDate) {
    if (widget.meeting.status == "FINISHED") {
      return Text('Meetingul s-a incheiat');
    }

    if (widget.meeting.status == "IN PROGRESS") {
      return Text('Meetingul a inceput');
    }

    if (_isOverdue) {
      return Text('Puteti intra in meeting');
    }

    return Text(_computeRemainingTime(startDate!));
  }
}
