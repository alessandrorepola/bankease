import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.iconData});
  final VoidCallback onPressed;
  final String text;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              shape: const CircleBorder(),
              minimumSize: const Size(50, 50),
            ),
            onPressed: (onPressed),
            child: Icon(
              iconData,
              color: Colors.white,
            )),
        const SizedBox(
          height: 9,
        ),
        Text(text)
      ],
    );
  }
}
