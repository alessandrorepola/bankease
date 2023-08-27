import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final IconData tileIcon;
  final String tileText;
  final VoidCallback selectFn;

  const DrawerItem({
    super.key,
    required this.tileIcon,
    required this.tileText,
    required this.selectFn,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Icon(
            tileIcon,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextButton(
              onPressed: selectFn,
              style: TextButton.styleFrom(
                alignment: Alignment.centerLeft,
              ),
              child: Text(
                tileText,
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      // tileColor: Colors.purple,
    );
  }
}
