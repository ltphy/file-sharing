import 'package:flutter/material.dart';

class CommandButtonIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon icon;
  final String label;
  final bool isLoading;

  const CommandButtonIcon({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: isLoading ? null : onPressed,
      // style: ButtonStyle(
      //     backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
      //   if (states.contains(MaterialState.disabled)) {
      //     return Colors.blue; // Disabled color
      //   }
      //   return Colors.blue; // Regular color
      // })),
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
        onSurface: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
        alignment: Alignment.center,
        elevation: 5,
      ),
      icon: SizedBox(
        width: 50,
        child: isLoading
            ? const Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    // backgroundColor: Colors.green,
                    color: Colors.purple,
                    strokeWidth: 5,
                  ),
                ),
              )
            : icon,
      ),
      label: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [Text(label, style: Theme.of(context).textTheme.bodyText1)],
      ),
    );
  }
}
