import 'package:flutter/material.dart';
import 'package:vot_senat_client/model/meeting.dart';
import 'package:vot_senat_client/pages/topic_page/topic_page.dart';

class MeetingCard extends StatelessWidget {
  final Meeting meeting;

  const MeetingCard({
    Key? key,
    required this.meeting,
  }) : super(key: key);

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
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
              child: Text(
                meeting.title ?? "",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            const Divider(),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TopicPage(meeting: meeting),
                          ),
                        );
                      },
                      child: const Text('Join')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
