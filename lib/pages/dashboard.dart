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
                const SizedBox(height: 20.0),
                Expanded(
                  child: Row(
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
                          child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            // Chart title
                            title:
                                ChartTitle(text: 'Half yearly sales analysis'),
                            // Enable legend
                            legend: Legend(isVisible: true),
                            // Enable tooltip
                            tooltipBehavior: TooltipBehavior(enable: true),
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
                                      const DataLabelSettings(isVisible: true))
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: Container(
                          margin: const EdgeInsets.all(8.0),
                          height: constraint.maxHeight,
                          width: constraint.maxWidth,
                          color: Colors.white,
                          child: SfSparkLineChart.custom(
                            //Enable the trackball
                            trackball: const SparkChartTrackball(
                                activationMode: SparkChartActivationMode.tap),
                            //Enable marker
                            marker: const SparkChartMarker(
                                displayMode: SparkChartMarkerDisplayMode.all),
                            //Enable data label
                            labelDisplayMode: SparkChartLabelDisplayMode.all,
                            xValueMapper: (int index) => data[index].year,
                            yValueMapper: (int index) => data[index].sales,
                            dataCount: 5,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
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
