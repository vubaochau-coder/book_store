import 'package:flutter/material.dart';

class BodyContent extends StatelessWidget {
  final Widget body;

  const BodyContent({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.delivery_dining_outlined,
          size: 18,
          color: Colors.transparent,
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(child: body),
      ],
    );
  }
}
