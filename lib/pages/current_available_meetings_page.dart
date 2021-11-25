import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vot_senat_client/bloc/available-meetings-bloc/available-meetings-bloc.dart';
import 'package:vot_senat_client/bloc/available-meetings-bloc/available-meetings-event.dart';
import 'package:vot_senat_client/bloc/available-meetings-bloc/available-meetings-state.dart';
import 'package:vot_senat_client/model/meeting.dart';

class AvailableMeetingsPage extends StatefulWidget {
  const AvailableMeetingsPage({Key? key}) : super(key: key);

  @override
  State<AvailableMeetingsPage> createState() => _AvailableMeetingsState();
}

class _AvailableMeetingsState extends State<AvailableMeetingsPage> {
  List<Meeting> cards = [
    new Meeting(id: 1, title: 'Sedinta 1', date: '05/07/2021'),
    new Meeting(id: 2, title: 'Sedinta 2', date: '08/07/2021'),
    new Meeting(id: 3, title: 'Sedinta 3', date: '12/09/2021'),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available meetings page"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: PhysicalModel(
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
                        cards[index].title,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    const Divider(),
                    Text(
                      'Programata in data de: ' + cards[index].date,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Ink(
                        width: 200,
                        height: 40,
                        child: InkWell(
                          splashColor: Colors.red,
                          // When the user taps the button, show a snackbar.
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Waiting for presenter...'),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Join',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
