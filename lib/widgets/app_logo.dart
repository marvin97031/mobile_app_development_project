import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 32});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: size / 2,
          backgroundColor: Colors.deepOrange,
          child: Icon(Icons.restaurant_menu,
              color: Colors.white, size: size * 0.6),
        ),
        const SizedBox(width: 8),
        Text('SmakBook',
            style: TextStyle(
                fontSize: size * 0.65, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
