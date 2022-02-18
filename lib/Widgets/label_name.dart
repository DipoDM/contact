import 'package:flutter/material.dart';

class LabelName extends StatelessWidget {
  final String labelText;
  const LabelName({
    Key key,
    this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7, bottom: 20),
      child: ExcludeSemantics(
        child: Text(
          labelText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
