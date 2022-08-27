import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vot_senat_client/model/meeting.dart';
import 'package:vot_senat_client/pages/topic_page/topic_page.dart';

class HistoryCard extends StatefulWidget {
  final Meeting meeting;

  const HistoryCard({Key? key, required this.meeting}) : super(key: key);

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.meeting.title ?? "",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.schedule,
                    color: Colors.black,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(DateFormat('dd-MM-yyyy - kk:mm').format(widget.meeting.startDate!)),
                ],
              ),
            ),
            const Divider(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TopicPage(
                      meeting: widget.meeting,
                      isEditMode: false,
                      isReadonly: true,
                    ),
                  ),
                );
              },
              child: Text("Vezi detalii"),
            ),
          ],
        ),
      ),
    );
  }
}
