import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vot_senat_client/bloc/meetings_bloc/meetings_bloc.dart';
import 'package:vot_senat_client/bloc/meetings_bloc/meetings_event.dart';
import 'package:vot_senat_client/bloc/meetings_bloc/meetings_state.dart';
import 'package:vot_senat_client/bloc/participation_bloc/participation_bloc.dart';
import 'package:vot_senat_client/bloc/participation_bloc/participation_state.dart';
import 'package:vot_senat_client/bloc/user_bloc/user_bloc.dart';
import 'package:vot_senat_client/bloc/user_bloc/user_event.dart';
import 'package:vot_senat_client/bloc/user_bloc/user_state.dart';
import 'package:vot_senat_client/handlers/role_handler.dart';
import 'package:vot_senat_client/handlers/shared_pref_handler.dart';
import 'package:vot_senat_client/model/meeting.dart';
import 'package:vot_senat_client/pages/invitation_page/invitation_page.dart';
import 'package:vot_senat_client/pages/meetings_history/meetings_history_page.dart';
import 'package:vot_senat_client/pages/topic_page/topic_page.dart';
import 'package:vot_senat_client/utils/roles.dart';
import 'package:vot_senat_client/widgets/meeting/meeting_card.dart';
import 'create_meeting_dialog.dart';

class AvailableMeetingsPage extends StatefulWidget {
  const AvailableMeetingsPage({Key? key}) : super(key: key);

  @override
  State<AvailableMeetingsPage> createState() => _AvailableMeetingsState();
}

class _AvailableMeetingsState extends State<AvailableMeetingsPage> {
  late List<Meeting> meetings;
  late Timer _getMeetingsTimer;
  late List<Function()> _bottomNavigatorOptions;

  @override
  void initState() {
    super.initState();

    meetings = [];
    //TODO add this to a method
    _bottomNavigatorOptions = [];
    _bottomNavigatorOptions.add(() => null);

    if (RoleHandler.instance.check([Roles.ADMIN, Roles.PRESIDENT])) {
      _bottomNavigatorOptions.add(
        () => showDialog(
          context: context,
          builder: (BuildContext context) => const CreateMeetingDialog(),
        ),
      );
    }

    _bottomNavigatorOptions.add(
      () => showDialog(
        context: context,
        builder: (BuildContext context) => const MeetingHistoryPage(),
      ),
    );

    if (RoleHandler.instance.check([Roles.ADMIN, Roles.PRESIDENT])) {
      _bottomNavigatorOptions.add(
        () => showDialog(
          context: context,
          builder: (BuildContext context) => const InvitationPage(),
        ),
      );
    }

    BlocProvider.of<MeetingsBloc>(context).add(MeetingsGetAll());
    _getMeetingsTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      BlocProvider.of<MeetingsBloc>(context).add(MeetingsGetAll());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MeetingsBloc, MeetingsState>(
          listener: _meetingsBlocListener,
        ),
        BlocListener<ParticipationBloc, ParticipationState>(
          listener: _participationListener,
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Sedinte"),
            centerTitle: true,
            actions: [
              PopupMenuButton<String>(
                onSelected: (String result) {},
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: "User",
                    child: BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
                      if (userState is UserAuthenticated) {
                        return Text("userName");
                      }

                      return Text("Neautentificat");
                    }),
                  ),
                  PopupMenuItem<String>(
                    value: "Logout",
                    child: Text('Logout'),
                    onTap: () => BlocProvider.of<UserBloc>(context).add(LogoutUser()),
                  ),
                ],
              ),
            ],
          ),
          body: BlocBuilder<ParticipationBloc, ParticipationState>(builder: (_, participationState) {
            if (participationState is ParticipationLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return BlocBuilder<MeetingsBloc, MeetingsState>(
              builder: (context, meetingsState) {
                if (meetingsState is MeetingsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (meetingsState is MeetingsSuccess) {
                  if (meetings.isEmpty) {
                    return const Center(
                      child: Text("Momentan nu exista sedinte"),
                    );
                  }

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
            );
          }),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Sedinte',
              ),
              if (RoleHandler.instance.check([Roles.ADMIN, Roles.PRESIDENT]))
                const BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'Adauga',
                ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'Istoric',
              ),
              if (RoleHandler.instance.check([Roles.ADMIN, Roles.PRESIDENT]))
                const BottomNavigationBarItem(
                  icon: Icon(Icons.send),
                  label: 'Invitatie',
                ),
            ],
            currentIndex: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.amber[800],
            unselectedItemColor: Colors.black,
            onTap: (index) {
              if (index < _bottomNavigatorOptions.length) {
                _bottomNavigatorOptions[index]();
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

    if (state is MeetingDeleteOneSuccess) {
      setState(() {
        meetings.removeWhere((meeting) => meeting.id == state.meetingId);
      });
    }
  }

  void _participationListener(BuildContext context, ParticipationState state) {
    if (state is ParticipationSuccess) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => TopicPage(
            meeting: state.meeting,
            isEditMode: false,
          ),
        ),
        (route) => false,
      );
      return;
    }
    if (state is ParticipationError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: const Text('S-a produs o erorare'),
        ),
      );
    }
  }

  @override
  void dispose() {
    if (_getMeetingsTimer.isActive) {
      _getMeetingsTimer.cancel();
    }
    super.dispose();
  }
}
