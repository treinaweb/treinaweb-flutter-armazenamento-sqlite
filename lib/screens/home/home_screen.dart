import 'package:flutter/material.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/screens/form_cadastro_pet/form_cadastro_pet_screen.dart';
import 'package:lifepet_app/services/pet_service.dart';

import 'components/pet_card.dart';

class HomeScreen extends StatelessWidget {
  PetService service = PetService();
  List<Pet> pets = List();

  HomeScreen() {
    _getAllPets();
  }

  @override
  Widget build(BuildContext context) {
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
  }

  void _getAllPets() {
    List list = service.getAllPets();
    pets = list;
  }
}
