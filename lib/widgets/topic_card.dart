import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:vot_senat_client/bloc/topic_bloc/topic_bloc.dart';
import 'package:vot_senat_client/bloc/topic_bloc/topic_event.dart';
import 'package:vot_senat_client/model/topic.dart';
import 'package:vot_senat_client/service/vote_service.dart';

class TopicCard extends StatefulWidget {
  final Topic topic;
  final int meetingId;
  final bool isReadonly;

  const TopicCard({
    Key? key,
    required this.topic,
    required this.meetingId,
    required this.isReadonly,
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Wrap(
                      children: [
                        Text(
                          widget.topic.content ?? "",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.visible,
                          style: Theme.of(context).textTheme.subtitle1,
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
                          title: Text('Delete ${widget.topic.content} ?'),
                          content: const Text('Are you sure you want to delete?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                TopicEvent event = TopicDelete(widget.topic.id!, widget.meetingId);
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
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InfoIndicator(
                    label: "Nu",
                    labelIcon: Icons.cancel_outlined,
                    labelColor: Colors.red,
                    value: '${widget.topic.no!}',
                  ),
                  InfoIndicator(
                    label: "Ma Abtin",
                    labelIcon: Icons.info_outline,
                    labelColor: Colors.orange,
                    value: '${widget.topic.abtain!}',
                  ),
                  InfoIndicator(
                    label: "Da",
                    labelIcon: Icons.check_circle_outline,
                    labelColor: Colors.green,
                    value: '${widget.topic.yes!}',
                  )
                ],
              ),
              const Divider(),
              if (!widget.isReadonly)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _TopicBottomSection(
                    topic: widget.topic,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoIndicator extends StatelessWidget {
  final IconData? labelIcon;
  final Color? labelColor;
  final String? label;
  final String value;

  const InfoIndicator({
    Key? key,
    this.labelIcon,
    this.labelColor,
    this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (label != null)
          Row(
            children: [
              if (labelIcon != null) ...[
                Icon(
                  labelIcon,
                  color: labelColor ?? Colors.black,
                  size: Theme.of(context).textTheme.bodyText1?.fontSize,
                ),
                const SizedBox(width: 4),
              ],
              if (label != null)
                Text(
                  label!,
                  style: TextStyle(
                    color: labelColor ?? Colors.black,
                  ),
                ),
            ],
          ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Theme.of(context).textTheme.subtitle1?.fontSize,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _TopicBottomSection extends StatelessWidget {
  final Topic topic;

  const _TopicBottomSection({
    Key? key,
    required this.topic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (topic.isActive!) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Topicul a intrat in votare...'),
            ),
          );
        },
        child: const Text("Activeaza"),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Material(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: () => VoteService.instance.vote(topic.id!, VoteValues.no),
            borderRadius: BorderRadius.circular(10),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
              child: Text(
                "Nu",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Material(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: () => VoteService.instance.vote(topic.id!, VoteValues.abtain),
            borderRadius: BorderRadius.circular(10),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "Ma abtin",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Material(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: () => VoteService.instance.vote(topic.id!, VoteValues.yes),
            borderRadius: BorderRadius.circular(10),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
              child: Text(
                "Da",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
