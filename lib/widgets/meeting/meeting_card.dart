import 'package:flutter/material.dart';
import 'package:vot_senat_client/model/meeting.dart';
import 'package:vot_senat_client/pages/topic_page/topic_page.dart';
import 'package:intl/intl.dart';

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
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 24),
                  Text(
                    meeting.title ?? "",
                    style: Theme.of(context).textTheme.subtitle2,
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
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Se sterge...'),
                          ),
                        );
                      },
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
                  _buildTimeText(meeting.startDate),
                ],
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

  String _computeRemainingTime(DateTime startDate) {
    int hours = (startDate.difference(DateTime.now()).inHours);
    int minutes = DateTime.now().difference(startDate).inMinutes % 60;
    return "Incepe in $hours ore si $minutes minute ";
  }

  Widget _buildTimeText(DateTime? startDate) {
    if (startDate == null) {
      return Text("Data nu a putut fi calculata");
    }
    if (DateTime.now().difference(startDate).inHours > 24) {
      return Text(DateFormat('dd-MM-yyyy - kk:mm').format(startDate));
    }
    return Text(_computeRemainingTime(startDate));
  }
}
