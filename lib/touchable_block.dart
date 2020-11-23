import 'package:flutter/material.dart';

class TouchableBlock extends StatelessWidget {
  TouchableBlock({@required this.title, @required this.height});

  final String title;
  double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.0,
      height: height,
      child: OutlinedButton(
        onPressed: () {
          print('touched');
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
        ),
      ),
    );
  }
}