import 'package:dashui/widgets/custom_page.dart';
import 'package:flutter/material.dart';

class Personal extends StatefulWidget {
  const Personal({Key key}) : super(key: key);

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: "Home | Personal",
      child: LayoutBuilder(
        builder: (context, constraint) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  height: constraint.maxHeight,
                  width: constraint.maxWidth,
                  color: Colors.white,
                ),
              ),
              Flexible(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  height: constraint.maxHeight,
                  width: constraint.maxWidth,
                  color: Colors.white,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
