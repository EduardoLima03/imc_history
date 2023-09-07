import 'package:flutter/material.dart';
import 'package:imc_history/models/imc_model.dart';
import 'package:imc_history/repositories/imc_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var imcRepository = ImcRepository();
  final _alturaControler = TextEditingController();
  final _pesoControler = TextEditingController();

  var _listImcs = <ImcModel>[];

  @override
  void initState() {
    super.initState();
    obterImcs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imc'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addImc(context);
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: _listImcs.length,
          itemBuilder: (BuildContext bc, int index) {
            var imcViwer = _listImcs[index];
            return Container(
              margin: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Data: ${imcViwer.data}',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Altura: ${imcViwer.altura}',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'Peso: ${imcViwer.peso}',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Imc: ${imcViwer.imc}',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'Clasificação: ${imcViwer.imcClassificacao(imcViwer.imc)}',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.blueGrey,
                  ),
                ],
              ),
            );
          }),
    );
  }

  addImc(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext bc) {
          return SizedBox(
            height: 272.0,
            child: AlertDialog(
              title: Text(
                'Adicionar IMC',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.07,
                ),
              ),
              content: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: _alturaControler,
                      decoration: const InputDecoration(labelText: 'Altura'),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: _pesoControler,
                      decoration: const InputDecoration(labelText: 'Peso'),
                    ),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar')),
                ElevatedButton(
                  onPressed: () async {
                    var imc = ImcModel(
                        altura: double.parse(_alturaControler.text),
                        peso: double.parse(_pesoControler.text));
                    imc.calculateImc();

                    await imcRepository.adicionarImc(imc);
                    limpaControllers();
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: const Text('Salvar'),
                ),
              ],
            ),
          );
        });
  }

  limpaControllers() {
    _alturaControler.text = '';
    _pesoControler.text = '';
  }

  obterImcs() async {
    _listImcs = await imcRepository.allImc();
  }
}
