import 'package:fixa_renda/data/investment/models/investiment_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:fixa_renda/util/num_extension.dart';

class InvestmentCard extends StatelessWidget {
  final InvestmentUiModel investmentUiModel;
  const InvestmentCard({
    super.key,
    required this.investmentUiModel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: SizedBox(
                  width: 6.0,
                  height: 12.0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0))),
                  ),
                ),
              ),
              Text('CDB',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(investmentUiModel.name,
                  style: Theme.of(context).textTheme.bodyLarge!),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Valor investido:'),
                    Text(
                      investmentUiModel.valueInvested.toCurrency(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Rendimento bruto:'),
                    Text(
                      investmentUiModel.profit.toCurrency(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Estimado 6 meses'),
                        Text('rendimento bruto',
                            style: Theme.of(context).textTheme.bodySmall!),
                      ],
                    ),
                    Text(
                      investmentUiModel.profit6months.toCurrency(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
