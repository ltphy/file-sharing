import 'package:flutter/material.dart';

class CustomOutlinedIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon icon;
  final String label;
  final bool isLoading;
  final Color? color;

  const CustomOutlinedIconButton({
    Key? key,
    this.color,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        primary: color ?? Colors.orange,
        side: BorderSide(
          color: color ?? Colors.orange,
          width: 1.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
        alignment: Alignment.center,
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
