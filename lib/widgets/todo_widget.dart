import 'package:flutter/material.dart';

class TodoWidget extends StatelessWidget {
  final String text;
  bool isCompleted;

  TodoWidget({Key? key, required this.text, required this.isCompleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          isCompleted
              ? const Icon(
                  Icons.task_alt,
                  color: Colors.grey,
                )
              : const Icon(Icons.radio_button_unchecked_outlined),
          const SizedBox(
            width: 15,
          ),
          Text(
            text,
            style: isCompleted
                ? const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 20,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  )
                : const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
          ),
        ],
      ),
    );
  }
}
