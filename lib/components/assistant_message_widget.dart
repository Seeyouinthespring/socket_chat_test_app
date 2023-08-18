import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AssistantMessageWidget extends StatelessWidget {
  final String text;
  final DateTime time;
  final Alignment alignment;

  const AssistantMessageWidget(
      {super.key, required this.text, required this.time, required this.alignment});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: UnconstrainedBox(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(30),
              topRight: const Radius.circular(30),
              bottomRight: alignment == Alignment.centerLeft ? const Radius.circular(30) : Radius.zero,
              bottomLeft: alignment == Alignment.centerRight ? const Radius.circular(30) : Radius.zero,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Color(0xFF455168),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                DateFormat('hh:mm').format(time),
                style: const TextStyle(
                  color: Color(0xFF667799),
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
