import 'package:flutter/material.dart';
import 'package:fixa_renda/util/num_extension.dart';

class InvestmentCard extends StatelessWidget {
  final String title;
  final num investedValue;
  final num grossIncome;
  const InvestmentCard(
      {super.key,
      required this.title,
      required this.investedValue,
      required this.grossIncome});

  @override
  Widget build(BuildContext context) {
    return Card(
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
              child: Text(title, style: Theme.of(context).textTheme.bodyLarge!),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Valor investido:'),
              Text(
                investedValue.toCurrency(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Rendimento bruto:'),
              Text(
                grossIncome.toCurrency(),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
