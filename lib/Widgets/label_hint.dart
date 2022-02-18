import 'package:flutter/material.dart';

class LabelHint extends StatelessWidget {
  final String displayText;
  const LabelHint({
    Key key,
    this.displayText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Text(
        displayText,
        style: const TextStyle(
          color: Colors.white60,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
