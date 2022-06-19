import 'package:flutter/material.dart';

class CustomPage extends StatelessWidget {
  final Widget child;
  final String title;
  final bool withBtn;
  final Function onSyncCallback;
  const CustomPage({
    Key key,
    this.child,
    this.title,
    this.withBtn = false,
    this.onSyncCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (withBtn) ...[
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  color: Colors.deepPurple,
                  onPressed: onSyncCallback,
                  padding: const EdgeInsets.all(18.0),
                  child: const Text(
                    "Synchroniser les données",
                    style: TextStyle(color: Colors.white, fontSize: 12.0),
                  ),
                )
              ]
            ],
          ),
        ),
        Expanded(
          child: child,
        )
      ],
    );
  }
}
