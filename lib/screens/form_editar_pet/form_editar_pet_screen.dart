import 'package:flutter/material.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/screens/home/home_screen.dart';
import 'package:lifepet_app/services/pet_service.dart';

class FormEditarPetScreen extends StatefulWidget {
  int id;

  FormEditarPetScreen({this.id});

  @override
  _FormEditarPetScreenState createState() => _FormEditarPetScreenState();
}

class _FormEditarPetScreenState extends State<FormEditarPetScreen> {

  final PetService petService = PetService();
  Pet pet;
  String _corPet;
  String _sexoPet;
   TextEditingController _nomeController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  TextEditingController _idadeController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();
  PetService service = PetService();
  Future<Pet> _loadPet;


  @override
  void initState() {
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
          _nomeController.text = pet.nome;
          _bioController.text = pet.bio;
          _idadeController.text = pet.idade.toString();
          _sexoPet = pet.sexo;
          _descricaoController.text = pet.descricao;
          _corPet = pet.cor;
          return Scaffold(
            appBar: AppBar(
              title: Text("Edição do pet"),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: _nomeController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: "Nome do pet"),
                      ),
                      TextFormField(
                        controller: _bioController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: "Bio"),
                      ),
                      TextFormField(
                        controller: _idadeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: "Idade"),
                      ),
                      DropdownButtonFormField(
                        value: _sexoPet,
                        onChanged: (String sexoSelecionado) {
                          setState(() {
                            _sexoPet = sexoSelecionado;
                          });
                        },
                        items: <String>['Macho', 'Fêmea'].map<DropdownMenuItem<
                            String>>
                          ((String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value)
                          );
                        }).toList(),
                      ),
                      TextFormField(
                        controller: _descricaoController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: "Descrição"),
                      ),
                      DropdownButtonFormField(
                        value: _corPet,
                        onChanged: (String corSelecionada) {
                          setState(() {
                            _corPet = corSelecionada;
                          });
                        },
                        items: <String>['Branco', 'Preto', 'Marrom', 'Amarelo']
                            .map<DropdownMenuItem<String>>
                          ((String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value)
                          );
                        }).toList(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          child: RaisedButton(
                            onPressed: () {
                              Pet newPet = Pet(
                                  id: pet.id,
                                  nome: _nomeController.text,
                                  bio: _bioController.text,
                                  idade: int.parse(_idadeController.text),
                                  sexo: _sexoPet,
                                  descricao: _descricaoController.text,
                                  cor: _corPet
                              );
                              service.editPet(pet.id, newPet);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => HomeScreen(),
                                ),
                              );
                            },
                            color: Colors.redAccent,
                            child: Text("Editar",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
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
      });
  }

  Future<Pet> _getPet(int id) async {
    return await service.getPet(id);
  }
}
