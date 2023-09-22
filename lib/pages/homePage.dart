// ignore: file_names
import 'package:app/service/via_cep_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _searchCepController = TextEditingController();
  bool _loading = false;
  bool _enableField = true;
  late String _result;

  @override
  void dispose() {
    super.dispose();
    _searchCepController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultar CEP'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildSearchCepTextField(),
            _buildSearchCepButton(),
            _buildResultForm()
          ],
        ),
      ),
    );
  }

  Widget _buildSearchCepTextField() {
    return TextField(
      autofocus: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(labelText: 'Cep'),
      controller: _searchCepController,
      enabled: _enableField,
    );
  }

  Widget _buildSearchCepButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: ElevatedButton(
        onPressed: _searchCep,
        style: const ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll(Color.fromARGB(255, 147, 46, 109))),
        child: _loading ? _circularLoading() : const Text('Consultar'),
      ),
    );
  }

  void _searching(bool enable) {
    setState(() {
      _result = enable ? '' : _result;
      _loading = enable;
      _enableField = !enable;
    });
  }

  Widget _circularLoading() {
    return Container(
      height: 15.0,
      width: 15.0,
      child: CircularProgressIndicator(),
    );
  }

  Future _searchCep() async {
    _searching(true);
    ViaCepService viaCep = new ViaCepService();

    final cep = _searchCepController.text;

    final resultCep = await viaCep.fetchCep(cep: cep);
    print(resultCep.localidade); // Exibindo somente a localidade no terminal

    setState(() {
      _result = resultCep.toJson();
    });

    _searching(false);
  }

  Widget _buildResultForm() {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Text(_result),
    );
  }
}
