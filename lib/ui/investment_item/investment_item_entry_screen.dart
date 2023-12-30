import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:fixa_renda/data/database.dart';
import 'package:fixa_renda/data/investment/investiment_repository.dart';
import 'package:fixa_renda/data/selic/api/selic_service.dart';
import 'package:fixa_renda/data/selic/selic_repository.dart';
import 'package:fixa_renda/ui/investment_item/investment_item_view_model.dart';
import 'package:fixa_renda/util/datetime_extension.dart';
import 'package:fixa_renda/util/string_extension.dart';
import 'package:provider/provider.dart';

class InvestmentItemEntryScreen extends StatefulWidget {
  static const routeName = 'investment-item-entry';

  const InvestmentItemEntryScreen({super.key});

  @override
  State<InvestmentItemEntryScreen> createState() =>
      _InvestmentItemEntryScreenState();
}

class _InvestmentItemEntryScreenState extends State<InvestmentItemEntryScreen> {
  DateTime selectedDate = DateTime.now();

  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _investedValueController = TextEditingController();
  final _rateController = TextEditingController();
  final _dateController =
      TextEditingController(text: DateTime.now().toBRDate());

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SelicRepository>(
          create: (context) => SelicRepository(
              selicDao:
                  Provider.of<AppDatabase>(context, listen: false).selicDao,
              selicService: Provider.of<SelicService>(context, listen: false)),
        ),
        Provider<InvestmentRepository>(
          create: (context) => InvestmentRepository(
              investmentDao: Provider.of<AppDatabase>(context, listen: false)
                  .investmentDao,
              selicRepository:
                  Provider.of<SelicRepository>(context, listen: false)),
        ),
        Provider<InvestmentItemViewModel>(
            create: (context) => InvestmentItemViewModel(
                investmentRepository:
                    Provider.of<InvestmentRepository>(context, listen: false))),
      ],
      builder: (context, _) => Scaffold(
          appBar: AppBar(),
          body: Form(
            key: _formKey,
            child: Column(children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFormField(
                            controller: _titleController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nome',
                              hintText: 'Ex: Tesouro Selic 2025',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Obrigatório';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFormField(
                            controller: _investedValueController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              CurrencyTextInputFormatter(
                                locale: 'pt_BR',
                                symbol: 'R\$',
                              )
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Obrigatório';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Valor investido',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFormField(
                            controller: _rateController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Obrigatório';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Porcentagem CDI',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFormField(
                            controller: _dateController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Obrigatório';
                              }
                              return null;
                            },
                            onTap: () {
                              _selectDate(context);
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Data da aplicação',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.shadow,
                      blurRadius: 4,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          context
                              .read<InvestmentItemViewModel>()
                              .createInvestmentItem(
                                  name: _titleController.text,
                                  date: selectedDate,
                                  valueInvested: _investedValueController.text
                                      .convertPriceToNum()!,
                                  interestRate: _rateController.text
                                      .convertPriceToNum()!);

                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Salvar'),
                    ),
                  ),
                ),
              ),
            ]),
          )),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = selectedDate.toBRDate();
        FocusScope.of(context).unfocus();
      });
    }
  }
}
