import 'package:flutter/material.dart';

class MiniButton extends StatelessWidget {
  const MiniButton({
    super.key,
    required this.icon,
  });
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, top: 10),
      child: Container(
        width: 45,
        height: 46,
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(
          icon,
          size: 27,
        ),
      ),
    );
  }
}
