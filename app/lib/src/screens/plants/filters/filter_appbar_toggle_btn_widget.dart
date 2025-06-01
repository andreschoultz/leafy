import 'package:flutter/material.dart';

class FilterAppBarToggleBtn extends StatelessWidget {
  const FilterAppBarToggleBtn({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: ElevatedButton.icon(
            onPressed: onPressed,
            label: Text(
              label,
              textAlign: TextAlign.center,
            ),
            icon: const Icon(
              Icons.expand_more,
              color: Colors.black87,
              weight: 5,
            ),
            iconAlignment: IconAlignment.end,
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 219, 225, 226)),
              foregroundColor: WidgetStatePropertyAll(Colors.black87),
              textStyle: WidgetStatePropertyAll(TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
              iconSize: WidgetStatePropertyAll(20),
              padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 14, vertical: 0)),
              alignment: Alignment.center,
              enableFeedback: true,
            ),
          ),
        ),
      ],
    );
  }
}
