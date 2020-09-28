import 'package:flutter/material.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/models/remedio_model.dart';
import 'package:lifepet_app/screens/components/custom_navbar.dart';
import 'package:lifepet_app/screens/form_cadastro_remedio/form_cadastro_remedio_screen.dart';
import 'package:lifepet_app/screens/remedio_pet/components/remedio_card.dart';
import 'package:lifepet_app/services/pet_service.dart';
import 'package:lifepet_app/services/remedio_service.dart';

class RemedioPetScreen extends StatelessWidget {
  final String id;
  List<Remedio> remedioList = List();
  final PetService petService = PetService();
  final RemedioService remedioService = RemedioService();
  Pet pet;

  RemedioPetScreen({this.id}){
    _getPet(id);
    _getRemedio(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Hero(
                tag: pet.id,
                child: Container(
                  width: double.infinity,
                  height: 350,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(pet.imageUrl),
                          fit: BoxFit.cover)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40, left: 10),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                ),
              )
            ],
          ),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Remédios",
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),)
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: remedioList.length,
              itemBuilder: (context, index) {
                return remedioCard(context, index, remedioList[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => FormCadastroRemedioScreen(id: pet.id,),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomNavbar(paginaAberta: 1, pet: pet,),
    );
  }

  void _getPet(String id) {
    pet = petService.getPet(id);
  }

  void _getRemedio(String id) {
    remedioList = remedioService.getRemediosPet(id);
  }
}
