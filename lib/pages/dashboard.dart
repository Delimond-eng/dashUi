import 'package:dashui/widgets/custom_page.dart';
import 'package:dashui/widgets/dash_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: "Home | DashBoard",
      child: LayoutBuilder(
        builder: (context, constraint) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 15.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Flexible(
                      child: DashCard(
                        icon: CupertinoIcons.bell_fill,
                        title: "Notifications",
                        subtitle: "all notifications for people",
                      ),
                    ),
                    Flexible(
                      child: DashCard(
                        icon: CupertinoIcons.group_solid,
                        title: "Presence",
                        subtitle: "work presences",
                      ),
                    ),
                    Flexible(
                      child: DashCard(
                        icon: CupertinoIcons.time,
                        title: "Tasks",
                        subtitle: "week tasks",
                      ),
                    ),
                    Flexible(
                      child: DashCard(
                        icon: CupertinoIcons.lock,
                        title: "Authorization",
                        subtitle: "access auth",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Expanded(child: Row(
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
          ),)
              ],
            ),
          );
        },
      ),
    );
  }
}
