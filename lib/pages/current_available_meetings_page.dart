import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vot_senat_client/model/meeting.dart';
import 'package:vot_senat_client/widgets/meeting/meeting_card.dart';

class AvailableMeetingsPage extends StatefulWidget {
  const AvailableMeetingsPage({Key? key}) : super(key: key);

  @override
  State<AvailableMeetingsPage> createState() => _AvailableMeetingsState();
}

class _AvailableMeetingsState extends State<AvailableMeetingsPage> {
  List<Meeting> cards = [
    Meeting(id: 1, title: 'Sedinta 1', date: '05/07/2021'),
    Meeting(id: 2, title: 'Sedinta 2', date: '08/07/2021'),
    Meeting(id: 3, title: 'Sedinta 3', date: '12/09/2021'),
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
              child: MeetingCard(
                title: cards[index].date,
                date: cards[index].date,
              ));
        },
      ),
    );
  }
}
