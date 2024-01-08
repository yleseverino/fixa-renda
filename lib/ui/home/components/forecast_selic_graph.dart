import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({super.key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  late List<Color> gradientColors = [
    Theme.of(context).colorScheme.primary,
    Theme.of(context).colorScheme.secondary,
  ];


  double touchedValue = - 1;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(
               // mainData(),
                avgData()
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('Mar', style: style);
        break;
      case 4:
        text = const Text('Jun', style: style);
        break;
      case 6:
        text = const Text('Sep', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 9:
        text = '9,0';
        break;
      case 10:
        text = '10,0';
        break;
      case 11:
        text = '11.0';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(

      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 1,
      maxX: 8,
      minY: 7,
      maxY: 13,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(1, 11.75),
            FlSpot(2, 10.75),
            FlSpot(3, 10.25),
            FlSpot(4, 9.75),
            FlSpot(5, 9.25),
            FlSpot(6, 9),
            FlSpot(7, 8.75),
            FlSpot(8, 8.5),
          ],
          isCurved: false,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((spotIndex) {
            return TouchedSpotIndicatorData(
              FlLine(
                color: Theme.of(context).colorScheme.secondary,
                strokeWidth: 4,
              ),
              FlDotData(
                getDotPainter: (spot, percent, barData, index) {

                    return FlDotSquarePainter(
                      size: 16,
                      color: Colors.white,
                      strokeWidth: 5,
                      strokeColor:
                      Theme.of(context).colorScheme.secondary,
                    );
                  }

              ),
            );
          }).toList();
        },
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Theme.of(context).colorScheme.tertiaryContainer,
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              final flSpot = barSpot;

              TextAlign textAlign;
              switch (flSpot.x.toInt()) {
                case 1:
                  textAlign = TextAlign.left;
                  break;
                case 5:
                  textAlign = TextAlign.right;
                  break;
                default:
                  textAlign = TextAlign.center;
              }

              return LineTooltipItem(
                'Selic atual\n',
                TextStyle(
                  color: Theme.of(context).colorScheme.onTertiaryContainer,

                ),
                children: [
                  TextSpan(
                    text: flSpot.y.toString() + ' %',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiaryContainer,

                    ),
                  ),

                ],
                textAlign: textAlign,
              );
            }).toList();
          },
        ),
        touchCallback:
            (FlTouchEvent event, LineTouchResponse? lineTouch) {
          if (!event.isInterestedForInteractions ||
              lineTouch == null ||
              lineTouch.lineBarSpots == null) {
            setState(() {
              touchedValue = -1;
            });
            return;
          }
          final value = lineTouch.lineBarSpots![0].x;

          setState(() {
            touchedValue = value;
          });
        },
      ),
      extraLinesData: ExtraLinesData(
        horizontalLines: [
          HorizontalLine(
            y: 1.8,
            color: Theme.of(context).colorScheme.tertiary,
            strokeWidth: 3,
            dashArray: [20, 10],
          ),
        ],
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 8,
      minY: 7.5,
      maxY: 12,
      lineBarsData: [
        LineChartBarData(
          isStepLineChart: true,
          spots: [11.75,11.25,10.75,10.25,9.75,9.25,9.0,8.75, 8.5].asMap().entries.map((e) {
            return FlSpot(e.key.toDouble(), e.value);
          }).toList(),
          isCurved: false,
          barWidth: 4,
          color: Theme.of(context).colorScheme.tertiary,
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                Theme.of(context).colorScheme.tertiary.withOpacity(0),
              ],
              stops: const [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            spotsLine: BarAreaSpotsLine(
              show: true,
              flLineStyle: FlLine(
                color: Theme.of(context).colorScheme.secondary,
                strokeWidth: 2,
              ),

            ),
          ),
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
                return FlDotSquarePainter(
                  size: 12,
                  color: Colors.white,
                  strokeWidth: 3,
                  strokeColor: Theme.of(context).colorScheme.secondary,
                );
            },

          ),
        ),
      ],


    );
  }
}