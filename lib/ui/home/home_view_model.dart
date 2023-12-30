import 'package:fixa_renda/data/investment/investiment_repository.dart';
import 'package:fixa_renda/data/investment/models/investiment_ui_model.dart';

class HomeViewModel {
  final InvestmentRepository _investmentRepository;
  late final Stream<List<InvestmentUiModel>> investments;

  HomeViewModel({required InvestmentRepository investmentRepository})
      : _investmentRepository = investmentRepository {
    investments = _investmentRepository.getInvestments();
  }
}
