import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vot_senat_client/bloc/meetings_history_bloc/meetings_history_bloc.dart';
import 'package:vot_senat_client/bloc/meetings_history_bloc/meetings_history_event.dart';
import 'package:vot_senat_client/bloc/meetings_history_bloc/meetings_history_state.dart';
import 'package:vot_senat_client/model/meeting.dart';
import 'package:vot_senat_client/widgets/history/meeting_history_card.dart';

class MeetingHistoryPage extends StatefulWidget {
  const MeetingHistoryPage({Key? key}) : super(key: key);

  @override
  State<MeetingHistoryPage> createState() => _MeetingsHistoryState();
}

class _MeetingsHistoryState extends State<MeetingHistoryPage> {
  late List<Meeting> meetingHistory;

  @override
  void initState() {
    super.initState();

    meetingHistory = [];
    BlocProvider.of<MeetingsHistoryBloc>(context).add(MeetingsHistoryGetAll());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MeetingsHistoryBloc, MeetingsHistoryState>(
          listener: _meetingsHistoryBlocListener,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("History meetings page"),
          centerTitle: true,
        ),
        body: BlocBuilder<MeetingsHistoryBloc, MeetingsHistoryState>(
          builder: (context, historyState) {
            if (historyState is MeetingsHistoryLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (historyState is MeetingsHistorySuccess) {
              return RefreshIndicator(
                child: ListView.builder(
                  itemCount: meetingHistory.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: HistoryCard(
                        meetingHistory: meetingHistory[index],
                      ),
                    );
                  },
                ),
                onRefresh: () async {
                  BlocProvider.of<MeetingsHistoryBloc>(context).add(MeetingsHistoryGetAll());
                  return;
                },
              );
            }

            if (historyState is MeetingsHistoryError) {
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
    );
  }

  void _meetingsHistoryBlocListener(BuildContext context, MeetingsHistoryState state) {
    if (state is MeetingsHistoryGetAllSuccess) {
      setState(() {
        meetingHistory = state.data;
      });
    }
  }
}
