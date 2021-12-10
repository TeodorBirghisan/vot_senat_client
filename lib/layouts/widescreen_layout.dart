import 'package:flutter/material.dart';

class WidescreenLayout extends StatelessWidget {

  //TODO get to a stable layout for widescreen and then
  //name each zone so that it is easier to pass widgets as children

  //TODO make a more custom app bar with actions and icons?
  //TBD pass appbar instead of customizin

  //TODO TBD inversionn of control so that external behavior can affect
  //layout such as sidebar?

  //TODO TBD sidebar logic inisde or outside of layout

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Helllo widescreen"),
      ),
      body: LimitedBox(
        child: Row(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                      width: 300,
                      color:Colors.yellow
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      color: Colors.red,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.blue,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
