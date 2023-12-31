import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:fixa_renda/data/investment/enum/investment_income_type.dart';
import 'package:fixa_renda/util/datetime_extension.dart';
import 'package:fixa_renda/util/string_extension.dart';
import 'package:fixa_renda/util/num_extension.dart';
import 'package:flutter/material.dart';

class InvestmentItemContent extends StatefulWidget {
  final void Function({
    required String name,
    required DateTime date,
    required num valueInvested,
    required num interestRate,
    required InvestmentIncomeType incomeType,
  }) onSave;

  final void Function()? onRemove;

  final String? name;
  final DateTime? date;
  final num? valueInvested;
  final num? interestRate;
  final InvestmentIncomeType? incomeType;

  const InvestmentItemContent(
      {super.key,
      required this.onSave,
      this.name,
      this.date,
      this.valueInvested,
      this.interestRate,
      this.onRemove,
      this.incomeType});

  @override
  State<InvestmentItemContent> createState() => _InvestmentItemContentState();
}

class _InvestmentItemContentState extends State<InvestmentItemContent> {
  late DateTime selectedDate = widget.date ?? DateTime.now();

  late InvestmentIncomeType dropdownValue =
      widget.incomeType ?? InvestmentIncomeType.posFixed;

  final _formKey = GlobalKey<FormState>();

  late final _titleController = TextEditingController(text: widget.name);
  late final _investedValueController =
      TextEditingController(text: widget.valueInvested?.toCurrency());
  late final _rateController =
      TextEditingController(text: widget.interestRate?.toBrFormat().toString());
  late final _dateController = TextEditingController(
      text: widget.date?.toBRDate() ?? DateTime.now().toBRDate());

  @override
  Widget build(BuildContext context) {
    return Form(
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
                          decimalDigits: 2,
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
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText:
                            InvestmentIncomeType.posFixed == dropdownValue
                                ? 'Porcentagem CDI'
                                : 'Porcentagem de rendimento',
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: SizedBox(
                          width: double.infinity,
                          child: DropdownButton<InvestmentIncomeType>(
                            value: dropdownValue,
                            underline: Container(),
                            isExpanded: true,
                            elevation: 0,
                            onChanged: (InvestmentIncomeType? value) {
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            items: InvestmentIncomeType.values
                                .map<DropdownMenuItem<InvestmentIncomeType>>(
                                    (InvestmentIncomeType value) {
                              return DropdownMenuItem<InvestmentIncomeType>(
                                value: value,
                                child: Text(
                                  value.description,
                                  style: Theme.of(context).textTheme!.bodyLarge,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
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
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        widget.onSave(
                            incomeType: dropdownValue,
                            name: _titleController.text,
                            date: selectedDate,
                            valueInvested: _investedValueController.text
                                .convertPriceToNum()!,
                            interestRate:
                                _rateController.text.convertPriceToNum()!);
                      }
                    },
                    child: Text(
                      'Salvar',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                if (widget.onRemove != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                        ),
                        onPressed: () {
                          widget.onRemove!();
                        },
                        child: Text('Remover',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                )),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ]),
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
