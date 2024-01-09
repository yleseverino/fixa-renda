import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample2 extends StatefulWidget {
  final List<String> listLabels;
  final List<double> listValues;
  final List<String> listMonths;
  const LineChartSample2({super.key, required this.listLabels, required this.listValues, required this.listMonths});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  double touchedValue = -1;

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
                avgData()),
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

    final String? label = widget.listMonths[value.toInt()];
    if (label != null) {
      text = Text(label, style: style);
    } else {
      text = const Text('', style: style);
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
    );
    String text;
    switch (value.toInt()) {
      case 9:
        text = '9,0 %';
        break;
      case 10:
        text = '10,0 %';
        break;
      case 11:
        text = '11,0 %';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
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
              FlDotData(getDotPainter: (spot, percent, barData, index) {
                return FlDotSquarePainter(
                  size: 16,
                  color: Colors.white,
                  strokeWidth: 5,
                  strokeColor: Theme.of(context).colorScheme.secondary,
                );
              }),
            );
          }).toList();
        },
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Theme.of(context).colorScheme.tertiaryContainer,
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              final flSpot = barSpot;



              return LineTooltipItem(
                '${widget.listLabels[flSpot.x.toInt()]}\n',
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
                textAlign: TextAlign.center,
              );
            }).toList();
          },
        ),
        touchCallback: (FlTouchEvent event, LineTouchResponse? lineTouch) {
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
      gridData: const FlGridData(
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
            reservedSize: 50,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false,  reservedSize: 50,),
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
          spots: widget.listValues
              .asMap()
              .entries
              .map((e) {
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
