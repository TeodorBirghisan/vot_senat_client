import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:vot_senat_client/bloc/topic_bloc/topic_bloc.dart';
import 'package:vot_senat_client/bloc/topic_bloc/topic_event.dart';
import 'package:vot_senat_client/model/meeting.dart';
import 'package:vot_senat_client/model/topic.dart';

class TopicCard extends StatefulWidget {
  final Topic topic;
  final int meetingId;

  const TopicCard({
    Key? key,
    required this.topic,
    required this.meetingId,
  }) : super(key: key);

  @override
  State<TopicCard> createState() => _TopicCardState();
}

class _TopicCardState extends State<TopicCard> {
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
                widget.topic.content ?? "",
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
                      primary: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      TopicEvent event =
                          TopicDelete(widget.topic.id!, widget.meetingId);
                      context.read<TopicBloc>().add(event);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Se sterge...'),
                        ),
                      );
                    },
                    child: const Text('Sterge'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Topicul a intrat in votare...'),
                          ),
                        );
                      },
                      child: const Text('Activeaza')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
