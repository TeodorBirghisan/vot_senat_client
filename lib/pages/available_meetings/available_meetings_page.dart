import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vot_senat_client/bloc/meetings_bloc/meetings_bloc.dart';
import 'package:vot_senat_client/bloc/meetings_bloc/meetings_event.dart';
import 'package:vot_senat_client/bloc/meetings_bloc/meetings_state.dart';
import 'package:vot_senat_client/bloc/user_bloc/user_bloc.dart';
import 'package:vot_senat_client/bloc/user_bloc/user_event.dart';
import 'package:vot_senat_client/model/meeting.dart';
import 'package:vot_senat_client/widgets/meeting/meeting_card.dart';

import 'create_meeting_dialog.dart';

class AvailableMeetingsPage extends StatefulWidget {
  const AvailableMeetingsPage({Key? key}) : super(key: key);

  @override
  State<AvailableMeetingsPage> createState() => _AvailableMeetingsState();
}

class _AvailableMeetingsState extends State<AvailableMeetingsPage> {
  late List<Meeting> meetings;

  @override
  void initState() {
    super.initState();

    meetings = [];
    BlocProvider.of<MeetingsBloc>(context).add(MeetingsGetAll());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MeetingsBloc, MeetingsState>(
          listener: _meetingsBlocListener,
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Available meetings page"),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: InkWell(
                    child: Text('Logout'),
                    onTap: () {
                      BlocProvider.of<UserBloc>(context).add(LogoutUser());
                    },
                  ),
                ),
              )
            ],
          ),
          body: BlocBuilder<MeetingsBloc, MeetingsState>(
            builder: (context, meetingsState) {
              if (meetingsState is MeetingsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (meetingsState is MeetingsSuccess) {
                return RefreshIndicator(
                  child: ListView.builder(
                    itemCount: meetings.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: MeetingCard(
                          meeting: meetings[index],
                        ),
                      );
                    },
                  ),
                  onRefresh: () async {
                    BlocProvider.of<MeetingsBloc>(context).add(MeetingsGetAll());
                    return;
                  },
                );
              }

              if (meetingsState is MeetingsError) {
                return const Center(
                  child: Text("Something wrong happend"),
                );
              }

              return const Center(
                child: Text("Unreachable state"),
              );
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Meetings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Create',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.send),
                label: 'Invite',
              ),
            ],
            currentIndex: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.amber[800],
            unselectedItemColor: Colors.black,
            onTap: (index) {
              if (index == 1) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const CreateMeetingDialog(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void _meetingsBlocListener(BuildContext context, MeetingsState state) {
    if (state is MeetingGetAllSuccess) {
      setState(() {
        meetings = state.data;
      });
    }

    if (state is MeetingCreateSuccess) {
      setState(() {
        meetings.add(state.data);
      });
    }
  }
}
