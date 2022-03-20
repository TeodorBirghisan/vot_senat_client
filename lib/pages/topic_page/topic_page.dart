import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vot_senat_client/bloc/topic_bloc/topic_bloc.dart';
import 'package:vot_senat_client/bloc/topic_bloc/topic_event.dart';
import 'package:vot_senat_client/bloc/topic_bloc/topic_state.dart';
import 'package:vot_senat_client/model/meeting.dart';
import 'package:vot_senat_client/model/topic.dart';
import 'package:vot_senat_client/widgets/topic_card.dart';

import 'create_topic_dialog.dart';

class TopicPage extends StatefulWidget {
  final Meeting meeting;
  const TopicPage({
    Key? key,
    required this.meeting,
  }) : super(key: key);

  @override
  State<TopicPage> createState() => _TopicState();
}

class _TopicState extends State<TopicPage> {
  late List<Topic> topics;

  @override
  void initState() {
    super.initState();

    topics = [];
    BlocProvider.of<TopicBloc>(context).add(TopicGetAll(widget.meeting));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TopicBloc, TopicState>(
          listener: _topicBlocListener,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Topics in meeting"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => CreateTopicDialog(
                meeting: widget.meeting,
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: BlocBuilder<TopicBloc, TopicState>(
          builder: (context, meetingsState) {
            if (meetingsState is TopicLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (meetingsState is TopicSuccess) {
              return RefreshIndicator(
                child: ListView.builder(
                  itemCount: topics.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      child: TopicCard(
                        meetingId: widget.meeting.id!,
                        topic: topics[index],
                      ),
                    );
                  },
                ),
                onRefresh: () async {
                  BlocProvider.of<TopicBloc>(context)
                      .add(TopicGetAll(widget.meeting));
                  return;
                },
              );
            }

            if (meetingsState is TopicError) {
              return const Center(
                child: Text("Something wrong happend"),
              );
            }

            return const Center(
              child: Text("Unreachable state"),
            );
          },
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: 'Topic',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.add),
        //       label: 'Create',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.history),
        //       label: 'History',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.send),
        //       label: 'Invite',
        //     ),
        //   ],
        //   currentIndex: 0,
        //   type: BottomNavigationBarType.fixed,
        //   selectedItemColor: Colors.amber[800],
        //   unselectedItemColor: Colors.black,
        //   onTap: (index) {
        //     if (index == 1) {
        //       showDialog(
        //         context: context,
        //         builder: (BuildContext context) => CreateMeetingDialog(),
        //       );
        //     }
        //   },
        // ),
      ),
    );
  }

  void _topicBlocListener(BuildContext context, TopicState state) {
    if (state is TopicGetAllSuccess) {
      setState(() {
        topics = state.data;
        // meetings = state.data;
      });
    }

    if (state is TopicCreateSuccess) {
      setState(() {
        topics.add(state.data);
        // meetings.add(state.data);
      });
    }

    if (state is TopicDeleteSuccess) {
      setState(() {
        topics.removeWhere((topic) => topic.id == state.topicId);
      });
    }
  }
}
