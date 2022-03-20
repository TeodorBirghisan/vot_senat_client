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
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 24),
                  Text(
                    widget.topic.content ?? "",
                    textAlign: TextAlign.center,
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
                      onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text('Delete ${widget.topic.content} ?'),
                          content:
                              const Text('Are you sure you want to delete?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                TopicEvent event = TopicDelete(
                                    widget.topic.id!, widget.meetingId);
                                context.read<TopicBloc>().add(event);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Se sterge...'),
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
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                widget.topic.content ?? "",
                                textAlign: TextAlign.center,
                              ),
                              content: const Text(
                                "Esti sigur ca vrei sa activezi votarea pentru acest topic",
                                textAlign: TextAlign.center,
                              ),
                              actions: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Material(
                                        color: Colors.white,
                                        child: InkWell(
                                          child: const Text(
                                            "Anuleaza",
                                            style: TextStyle(
                                                color: Colors.blueAccent),
                                          ),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                      // ElevatedButton(
                                      //   style: ElevatedButton.styleFrom(
                                      //     primary: Colors.white,
                                      //   ),
                                      //   onPressed: () {
                                      //     Navigator.of(context).pop();
                                      //   },
                                      //   child: Text(
                                      //     "Anuleaza",
                                      //     style: TextStyle(color: Colors.blueAccent),
                                      //   ),
                                      // ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.blueAccent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Topicul a intrat in votare...'),
                                            ),
                                          );
                                        },
                                        child: const Text("Activeaza"),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
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
