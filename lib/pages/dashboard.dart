import 'package:dashui/responsive/base_widget.dart';
import 'package:dashui/responsive/enum_screens.dart';
import 'package:dashui/widgets/custom_page.dart';
import 'package:dashui/widgets/dash_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  ScrollController scrollController = ScrollController();
  List<SalesData> data = [
    SalesData('Jan', 35),
    SalesData('Feb', 28),
    SalesData('Mar', 34),
    SalesData('Apr', 32),
    SalesData('May', 40)
  ];
  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: "Home | DashBoard",
      child: LayoutBuilder(
        builder: (context, constraint) {
          return Responsive(
            builder: (context, responsiveInfo) {
              return Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                ),
                child: Scrollbar(
                  isAlwaysShown: true,
                  radius: const Radius.circular(10.0),
                  thickness: 5,
                  controller: scrollController,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GridView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio:
                                (responsiveInfo.deviceScreenType ==
                                        DeviceScreenType.Tablet)
                                    ? 3.50
                                    : (responsiveInfo.deviceScreenType ==
                                            DeviceScreenType.Mobile)
                                        ? 3.70
                                        : 3.50,
                            crossAxisCount: (responsiveInfo.deviceScreenType ==
                                    DeviceScreenType.Tablet)
                                ? 2
                                : (responsiveInfo.deviceScreenType ==
                                        DeviceScreenType.Mobile)
                                    ? 1
                                    : 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10.0,
                          ),
                          children: const [
                            DashCard(
                              icon: CupertinoIcons.bell_fill,
                              title: "Notifications",
                              subtitle: "all notifications for people",
                            ),
                            DashCard(
                              icon: CupertinoIcons.group_solid,
                              title: "Presence",
                              subtitle: "work presences",
                            ),
                            DashCard(
                              icon: CupertinoIcons.time,
                              title: "Tasks",
                              subtitle: "week tasks",
                            ),
                            DashCard(
                              icon: CupertinoIcons.lock,
                              title: "Authorization",
                              subtitle: "access auth",
                            )
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 5,
                              child: Container(
                                height: constraint.maxHeight / 2,
                                width: constraint.maxWidth,
                                padding: const EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: SfCartesianChart(
                                  primaryXAxis: CategoryAxis(),

                                  // Chart title
                                  title: ChartTitle(
                                      text: 'Half yearly sales analysis'),
                                  // Enable legend
                                  legend: Legend(isVisible: true),
                                  // Enable tooltip
                                  tooltipBehavior:
                                      TooltipBehavior(enable: true),
                                  series: <ChartSeries<SalesData, String>>[
                                    LineSeries<SalesData, String>(
                                      dataSource: data,
                                      xValueMapper: (SalesData sales, _) =>
                                          sales.year,
                                      yValueMapper: (SalesData sales, _) =>
                                          sales.sales,
                                      name: 'Sales',
                                      // Enable data label
                                      dataLabelSettings:
                                          DataLabelSettings(isVisible: true),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              flex: 5,
                              child: Container(
                                padding: const EdgeInsets.all(20.0),
                                height: constraint.maxHeight / 2,
                                width: constraint.maxWidth,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: SfSparkLineChart.custom(
                                  //Enable the trackball
                                  trackball: SparkChartTrackball(
                                    activationMode:
                                        SparkChartActivationMode.tap,
                                  ),
                                  //Enable marker
                                  marker: SparkChartMarker(
                                    displayMode:
                                        SparkChartMarkerDisplayMode.all,
                                  ),
                                  //Enable data label
                                  labelDisplayMode:
                                      SparkChartLabelDisplayMode.all,
                                  xValueMapper: (int index) => data[index].year,
                                  yValueMapper: (int index) =>
                                      data[index].sales,
                                  dataCount: 5,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
