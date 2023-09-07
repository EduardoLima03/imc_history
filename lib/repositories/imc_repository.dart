import 'package:imc_history/models/imc_model.dart';

class ImcRepository {
  final List<ImcModel> _imcs = [];

  Future<List<ImcModel>> allImc() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _imcs;
  }

  Future<void> adicionarImc(ImcModel imc) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _imcs.add(imc);
  }
}
