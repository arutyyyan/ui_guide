import 'package:flutter/material.dart';

class IconBox extends StatelessWidget {
  final String title;
  final Icon iconName;
  Function onPressed;

  IconBox({@required this.title, @required this.iconName, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        Ink(
          decoration: const ShapeDecoration(
            color: Colors.black12,
            shape: CircleBorder(),
          ),
          child: IconButton(
              icon: iconName,
              color: Colors.white70,
              iconSize: 40.0,
              onPressed: onPressed
          ),
        ),
      ],
    );
  }
}
