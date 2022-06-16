import 'package:dashui/global/controllers.dart';
import 'package:dashui/helpers/navigator.dart';
import 'package:dashui/responsive/base_widget.dart';
import 'package:dashui/responsive/enum_screens.dart';
import 'package:dashui/responsive/sizing_info.dart';
import 'package:dashui/widgets/expandable_menu_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Responsive(
      builder: (context, responsiveInfo) {
        return Scaffold(
          drawer: responsiveInfo.deviceScreenType == DeviceScreenType.Desktop
              ? null
              : const Sidebar(),
          key: _globalKey,
          appBar: _customAppBar(responsiveInfo),
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
                    if (responsiveInfo.deviceScreenType ==
                        DeviceScreenType.Desktop) ...[
                      _customSidebar(),
                    ],
                    _customBody(boxConstraint)
                  ],
                ),
              );
            },
          ),
        );
      },
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

  Expanded _customSidebar() {
    return const Expanded(
      flex: 2,
      child: Sidebar(),
    );
  }

  Widget _customAppBar(SizingInfo responsiveInfo) {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black54, size: 18.0),
      elevation: 0,
      title: Row(
        children: [
          if (responsiveInfo.deviceScreenType == DeviceScreenType.Desktop) ...[
            const Icon(
              Icons.data_saver_off_rounded,
              color: Colors.pink,
              size: 20.0,
            ),
            const SizedBox(
              width: 10.0,
            ),
          ],
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

class Sidebar extends StatelessWidget {
  const Sidebar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Responsive(
      builder: (context, responsiveInfo) {
        return Container(
          width: responsiveInfo.deviceScreenType == DeviceScreenType.Desktop
              ? screenSize.width
              : 250,
          height: screenSize.height,
          decoration: BoxDecoration(
            color: Colors.grey[100].withOpacity(.9),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ExpandableMenuItem(
                  icon: CupertinoIcons.home,
                  label: "Home",
                  childs: [
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
                  ],
                ),
                ExpandableMenuItem(
                  icon: Icons.calendar_today_outlined,
                  label: "Calendar",
                  childs: [
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
              ],
            ),
          ),
        );
      },
    );
  }
}

class MenuItem extends StatelessWidget {
  final MaterialColor color;
  final IconData icon;
  final String label;
  final Function onPressed;
  const MenuItem({
    Key key,
    this.color,
    this.label,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  icon ?? Icons.arrow_right_alt_outlined,
                  color: color ?? Colors.black,
                  size: 18.0,
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Text(
                  label,
                  style: TextStyle(
                    color: color ?? Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
