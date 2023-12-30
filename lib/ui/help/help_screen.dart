import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});
  static const routeName = 'help';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajuda'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                  "Este aplicativo foi desenvolvido para ajudar a calcular o rendimento de investimentos em renda fixa e assim poder comparar suas oportunidades de CDB, LCI, LCA, LC, etc."),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                  "Para isso, basta informar o valor investido, a taxa de rendimento e a data do investimento e será calculado o rendimento bruto e líquido do investimento."),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text("Agradecimentos",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                  "Meus agradescimentos a minha esposa, Júlia Zuanazzi que me apoiou e incentivou a desenvolver este aplicativo e me apoia em tudo que faço."),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text("Ícone do app feito por Freepik no flaticon.com"),
            ),
            const Spacer(),
            Text("Fixa Renda",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
            Text.rich(TextSpan(
                text: "Copyright 2023 ",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                children: [
                  TextSpan(
                    text: "Yle Severino Carvalho",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  )
                ]))
          ],
        ),
      ),
    );
  }
}
