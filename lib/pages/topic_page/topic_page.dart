import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vot_senat_client/bloc/participants_bloc/participants_bloc.dart';
import 'package:vot_senat_client/bloc/participants_bloc/participants_event.dart';
import 'package:vot_senat_client/bloc/participants_bloc/participants_state.dart';
import 'package:vot_senat_client/bloc/participation_bloc/participation_bloc.dart';
import 'package:vot_senat_client/bloc/participation_bloc/participation_event.dart';
import 'package:vot_senat_client/bloc/topic_bloc/topic_bloc.dart';
import 'package:vot_senat_client/bloc/topic_bloc/topic_event.dart';
import 'package:vot_senat_client/bloc/topic_bloc/topic_state.dart';
import 'package:vot_senat_client/model/meeting.dart';
import 'package:vot_senat_client/model/topic.dart';
import 'package:vot_senat_client/model/user.dart';
import 'package:vot_senat_client/widgets/topic_card.dart';

import 'create_topic_dialog.dart';

class TopicPage extends StatefulWidget {
  final Meeting meeting;
  final bool isEditMode;
  final bool? isReadonly;

  const TopicPage({
    Key? key,
    required this.meeting,
    required this.isEditMode,
    this.isReadonly,
  }) : super(key: key);

  @override
  State<TopicPage> createState() => _TopicState();
}

class _TopicState extends State<TopicPage> {
  late List<Topic> topics;
  late Timer? _participantsTimer;
  late List<User> _participants;

  @override
  void initState() {
    super.initState();

    topics = [];
    _participantsTimer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        BlocProvider.of<ParticipantsBloc>(context).add(ParticipantsGetAll(widget.meeting));
      },
    );
    BlocProvider.of<TopicBloc>(context).add(TopicGetAll(widget.meeting));
    BlocProvider.of<ParticipantsBloc>(context).add(ParticipantsGetAll(widget.meeting));
    _participants = [];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!widget.isEditMode) {
          BlocProvider.of<ParticipationBloc>(context).add(ExitMeeting(widget.meeting));
        }

        Navigator.of(context).pushNamedAndRemoveUntil("/available-meetings", (_) => false);
        return true;
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<TopicBloc, TopicState>(
            listener: _topicBlocListener,
          ),
          BlocListener<ParticipantsBloc, ParticipantsState>(
            listener: _participantsBlocListener,
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Topics in meeting"),
            centerTitle: true,
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: widget.isReadonly ?? false
                ? []
                : [
                    if (!widget.isEditMode)
                      FloatingActionButton(
                        heroTag: "users",
                        onPressed: () {
                          BlocProvider.of<ParticipantsBloc>(context).add(ParticipantsGetAll(widget.meeting));
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (_) => FractionallySizedBox(
                              heightFactor: 0.9,
                              child: ParticipantsBottomSheet(
                                participants: _participants,
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Center(
                                child: Text(
                                  _participants.length.toString(),
                                  style: const TextStyle(),
                                ),
                              ),
                            ),
                            const Align(
                              child: Icon(Icons.person),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(width: 16),
                    FloatingActionButton(
                      heroTag: "add",
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
                  ],
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
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: TopicCard(
                          meetingId: widget.meeting.id!,
                          topic: topics[index],
                          isReadonly: widget.isReadonly ?? false,
                        ),
                      );
                    },
                  ),
                  onRefresh: () async {
                    BlocProvider.of<TopicBloc>(context).add(TopicGetAll(widget.meeting));
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    _participantsTimer!.cancel();
    super.dispose();
  }

  void _topicBlocListener(BuildContext context, TopicState state) {
    if (state is TopicGetAllSuccess) {
      setState(() {
        topics = state.data;
        // meetings = state.data;
      });
    }

    if (state is TopicCreateSuccess) {
      BlocProvider.of<TopicBloc>(context).add(TopicGetAll(widget.meeting));
    }

    if (state is TopicDeleteSuccess) {
      setState(() {
        topics.removeWhere((topic) => topic.id == state.topicId);
      });
    }
  }

  void _participantsBlocListener(BuildContext context, ParticipantsState participantsState) {
    if (participantsState is ParticipantsGetSuccess) {
      setState(() {
        _participants = participantsState.users;
      });
    }
  }
}

class ParticipantsBottomSheet extends StatefulWidget {
  final List<User> participants;

  const ParticipantsBottomSheet({
    Key? key,
    required this.participants,
  }) : super(key: key);

  @override
  State<ParticipantsBottomSheet> createState() => _ParticipantsBottomSheetState();
}

class _ParticipantsBottomSheetState extends State<ParticipantsBottomSheet> {
  late List<User> _participants;

  @override
  void initState() {
    super.initState();
    _participants = widget.participants;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ParticipantsBloc, ParticipantsState>(
          listener: _participantsBlocListener,
        ),
      ],
      child: BlocBuilder<ParticipantsBloc, ParticipantsState>(
        builder: (_, participantsState) {
          if (participantsState is ParticipantsGetSuccess || participantsState is ParticipantsLoading) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "Participanti",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Numar de participanti",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        _participants.length.toString(),
                        style: Theme.of(context).textTheme.subtitle1,
                      )
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 16),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: _participants.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (_, index) => Row(
                      children: [
                        Icon(Icons.person),
                        const SizedBox(width: 8),
                        Text(_participants[index].email),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          if (participantsState is ParticipantsGetFailure) {
            return const Center(
              child: Text("Error State"),
            );
          }

          return Text("Unreachable State");
        },
      ),
    );
  }

  void _participantsBlocListener(BuildContext context, ParticipantsState participantsState) {
    if (participantsState is ParticipantsGetSuccess) {
      _participants = participantsState.users;
    }
  }
}
