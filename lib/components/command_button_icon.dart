import 'package:flutter/material.dart';

class CommandButtonIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon icon;
  final String label;

  const CommandButtonIcon(
      {Key? key,
      required this.onPressed,
      required this.icon,
      required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(
        label,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
