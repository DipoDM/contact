import 'package:contact/Controllers/constants.dart';
import 'package:flutter/material.dart';

class MediaButton extends StatelessWidget {
  final IconData buttonIcon;
  final Function action;
  final String buttonName;
  final String semanticLabel;

  const MediaButton({
    Key key,
    this.buttonIcon,
    this.action,
    this.buttonName,
    this.semanticLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Semantics(
          label: "$buttonName $semanticLabel",
          child: Column(
            children: [
              Card(
                color: Colors.grey[850],
                child: IconButton(
                  splashColor: kVisaBlue,
                  onPressed: () {
                    action;
                  },
                  icon: Icon(
                    buttonIcon,
                    color: kVisaGold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExcludeSemantics(
                  child: Text(
                    buttonName,
                    style: TextStyle(
                        color: kVisaGold, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
