import 'package:dashui/global/controllers.dart';
import 'package:dashui/helpers/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _customAppBar(),
      body: LayoutBuilder(
        builder: (context, boxConstraint) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img_2.jpg"),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
            child: Row(
              children: [
                _customSidebar(boxConstraint),
                _customBody(boxConstraint)
              ],
            ),
          );
        },
      ),
    );
  }

  Expanded _customBody(BoxConstraints boxConstraint) {
    return Expanded(
      flex: 9,
      child: Container(
        width: boxConstraint.maxWidth,
        height: boxConstraint.maxHeight,
        color: Colors.grey[200].withOpacity(.5),
        padding: const EdgeInsets.all(10.0),
        child: localNavigator(),
      ),
    );
  }

  Expanded _customSidebar(BoxConstraints boxConstraint) {
    return Expanded(
      flex: 2,
      child: Container(
        width: boxConstraint.maxWidth,
        height: boxConstraint.maxHeight,
        decoration: BoxDecoration(
          color: Colors.grey[100].withOpacity(.9),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const MenuItem(
                icon: CupertinoIcons.home,
                isMainTitle: true,
                label: "Home",
              ),
              MenuItem(
                label: "Dashboard",
                color: Colors.blue,
                onPressed: () {
                  navigatorController.navigateTo("/");
                },
              ),
              MenuItem(
                label: "Personal",
                color: Colors.orange,
                onPressed: () {
                  navigatorController.navigateTo("/personal");
                },
              ),
              const MenuItem(
                icon: Icons.calendar_today_outlined,
                isMainTitle: true,
                label: "Calendar",
              ),
              MenuItem(
                label: "Tasks",
                color: Colors.deepPurple,
                onPressed: () {},
              ),
              MenuItem(
                label: "Timing plans",
                color: Colors.blue,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          const Icon(
            Icons.more,
            color: Colors.black,
            size: 20.0,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Text(
            'Dash Ui',
            style: TextStyle(
              color: Colors.blue[700],
              fontWeight: FontWeight.w900,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(CupertinoIcons.search, color: Colors.black),
          onPressed: () {},
        ),
        const SizedBox(
          width: 5.0,
        ),
        Container(
          height: 40.0,
          width: 40.0,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.2),
                blurRadius: 10.0,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Center(
            child: Icon(Icons.more_vert_outlined, color: Colors.black),
          ),
          margin: const EdgeInsets.only(right: 15.0),
        )
      ],
    );
  }
}

class MenuItem extends StatelessWidget {
  final bool isMainTitle;
  final MaterialColor color;
  final IconData icon;
  final String label;
  final Function onPressed;
  const MenuItem({
    Key key,
    this.isMainTitle = false,
    this.color,
    this.label,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: isMainTitle
            ? Border(
                bottom: BorderSide(
                  color: Colors.grey[200].withOpacity(.7),
                ),
              )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    if (isMainTitle) ...[
                      Icon(
                        icon,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                    ],
                    Padding(
                      padding: EdgeInsets.only(left: isMainTitle ? 0 : 15.0),
                      child: Text(
                        label,
                        style: TextStyle(
                          color: color ?? Colors.black,
                          fontWeight:
                              isMainTitle ? FontWeight.w900 : FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                if (isMainTitle) ...[
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.blue,
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
