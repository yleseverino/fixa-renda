import 'package:fixa_renda/ui/home/components/forecast_selic_card/forecast_graph_ui_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ForecastSelicGraph extends StatefulWidget {
  final List<ForecastGraphUiModel> forecastGraphUiModel;

  const ForecastSelicGraph({super.key, required this.forecastGraphUiModel});

  @override
  State<ForecastSelicGraph> createState() => _ForecastSelicGraphState();
}

class _ForecastSelicGraphState extends State<ForecastSelicGraph> {
  double touchedValue = -1;

  late final List<String> listMonths =
      widget.forecastGraphUiModel.map((e) => e.month).toList();
  late final List<double> listValues =
      widget.forecastGraphUiModel.map((e) => e.value).toList();
  late final List<String> listLabels =
      widget.forecastGraphUiModel.map((e) => e.label).toList();

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
            child: LineChart(data()),
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

    try {
      final String label = listMonths[value.toInt()];
      text = Text(label, style: style);
    } on RangeError {
      text = Container();
    }

    if (value == (widget.forecastGraphUiModel.length - 1)) {
      text = Container();
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

  LineChartData data() {
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
                  color: Theme.of(context).colorScheme.primary,
                  strokeWidth: 5,
                  strokeColor: Theme.of(context).colorScheme.onPrimary,
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
                '${listLabels[flSpot.x.toInt()]}\n',
                TextStyle(
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
                children: [
                  TextSpan(
                    text: '${flSpot.y} %',
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
            strokeWidth: 1,
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
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 50,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: widget.forecastGraphUiModel.length.toDouble() - 1,
      minY: 7.5,
      maxY: 12,
      lineBarsData: [
        LineChartBarData(
          isStepLineChart: true,
          spots: listValues.asMap().entries.map((e) {
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
                size: 6,
                color: Colors.white,
                strokeWidth: 2,
                strokeColor: Theme.of(context).colorScheme.secondary,
              );
            },
          ),
        ),
      ],
    );
  }
}
