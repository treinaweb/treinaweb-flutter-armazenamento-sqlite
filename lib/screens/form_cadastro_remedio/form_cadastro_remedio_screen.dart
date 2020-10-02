import 'package:flutter/material.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/models/remedio_model.dart';
import 'package:lifepet_app/screens/remedio_pet/remedio_pet_screen.dart';
import 'package:lifepet_app/services/pet_service.dart';
import 'package:lifepet_app/services/remedio_service.dart';

class FormCadastroRemedioScreen extends StatefulWidget {
  int id;

  FormCadastroRemedioScreen({this.id});

  @override
  _FormCadastroRemedioScreenState createState() => _FormCadastroRemedioScreenState();
}

class _FormCadastroRemedioScreenState extends State<FormCadastroRemedioScreen> {
  final _nomeController = TextEditingController();
  final _dataController = TextEditingController();
  final PetService petService = PetService();
  final RemedioService remedioService = RemedioService();
  Pet pet;
  Future<Pet> _loadPet;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPet = _getPet(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadPet,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          pet = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text("Cadastro de remédio do ${pet.nome}"),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        controller: _nomeController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: "Nome do remédio"),
                      ),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: _dataController,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                                labelText: selectedDate.toString()),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Container(
                          height: 40,
                          child: RaisedButton(
                            onPressed: () {
                              Remedio novoRemedio = Remedio(
                                nome: _nomeController.text,
                                data: selectedDate.toString(),
                                pet: pet.id
                              );
                              remedioService.addRemedio(novoRemedio);
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => RemedioPetScreen(id: pet.id),
                                ),
                              );
                            },
                            color: Colors.redAccent,
                            child: Text("Cadastrar", style: TextStyle(
                                color: Colors.white, fontSize: 16
                            ),),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime dataSelecionada = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2019, 1),
        lastDate: DateTime(2030));
    if (dataSelecionada != null && dataSelecionada != selectedDate) {
      setState(() {
        selectedDate = dataSelecionada;
      });
    }
  }

  Future<Pet> _getPet(int id) async {
    return await petService.getPet(id);
  }
}
