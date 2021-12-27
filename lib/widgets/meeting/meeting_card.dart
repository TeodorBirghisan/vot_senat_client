import 'package:flutter/material.dart';

class MeetingCard extends StatelessWidget {
  final String title;
  //TODO: Date into date type?
  final String date;
  const MeetingCard({Key? key, this.title = '', this.date = 'DD-MM-YYYY'})
      : super(key: key);

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
                title,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            const Divider(),
            Text(
              'Programata in data de: ' + date,
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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue),
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
    );
  }
}
