import 'package:flutter/material.dart';

class TimeField extends StatelessWidget {
  const TimeField({Key? key, required this.time}) : super(key: key);
  final TimeOfDay time;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.grey[200],
      ),
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              time.format(context),
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Icon(
            Icons.access_time_outlined,
            size: 18.0,
          ),
        ],
      ),
    );
  }
}
