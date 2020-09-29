import 'package:flutter/material.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/screens/form_cadastro_pet/form_cadastro_pet_screen.dart';
import 'package:lifepet_app/services/pet_service.dart';

import 'components/pet_card.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PetService service = PetService();
  List<Pet> pets = List();
  Future<List> _loadPets;

  @override
  void initState() {
    // TODO: implement initState
    _loadPets = _getAllPets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadPets,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if (snapshot.hasData) {
          pets = snapshot.data;
          return Scaffold(
            backgroundColor: Colors.white,
            body: ListView.builder(
              itemCount: pets.length,
              itemBuilder: (context, index) {
                return petCard(context, index, pets[index]);
              },
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => FormCadastroPetScreen(),
                  ),
                );
              },
              label: Text("Cadastrar"),
              icon: Icon(Icons.pets),
              backgroundColor: Colors.redAccent,
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

  Future<List> _getAllPets() async {
    return await service.getAllPets();
  }
}
