import 'package:fixa_renda/ui/home/components/forecast_selic_card/forecast_graph_ui_model.dart';
import 'package:fixa_renda/ui/home/components/forecast_selic_card/forecast_selic_graph.dart';
import 'package:fixa_renda/util/datetime_extension.dart';
import 'package:flutter/material.dart';

class ForecastSelicCard extends StatelessWidget {
  final double selic;
  final List<ForecastGraphUiModel> forecastGraphUiModel;

  const ForecastSelicCard(
      {super.key, required this.forecastGraphUiModel, required this.selic});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Previsão da taxa Selic',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ForecastSelicGraph(
                  forecastGraphUiModel: [
                    ForecastGraphUiModel(
                        label: 'Selic Atual',
                        value: selic,
                        month: '',
                        lastDate: DateTime.now()),
                    ...forecastGraphUiModel
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Relatório Focus (${forecastGraphUiModel.first.lastDate.toBRDate()})',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
