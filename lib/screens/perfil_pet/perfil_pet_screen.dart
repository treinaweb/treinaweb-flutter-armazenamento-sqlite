import 'package:flutter/material.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/screens/form_cadastro_pet/form_cadastro_pet_screen.dart';
import 'package:lifepet_app/screens/components/custom_navbar.dart';
import 'package:lifepet_app/screens/form_editar_pet/form_editar_pet_screen.dart';
import 'package:lifepet_app/services/pet_service.dart';

import 'components/cartao_info_pet.dart';

class PerfilPetScreen extends StatefulWidget {

  final int id;

  PerfilPetScreen({this.id});

  @override
  _PerfilPetScreenState createState() => _PerfilPetScreenState();
}

class _PerfilPetScreenState extends State<PerfilPetScreen> {
  PetService service = PetService();
  Pet pet;
  Future<Pet> _loadPet;

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
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if (snapshot.hasData) {
          pet = snapshot.data;
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
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
                                  image: AssetImage(
                                      pet.imageUrl
                                  ),
                                  fit: BoxFit.cover
                              )
                          ),
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
                        Text(
                          pet.nome,
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          pet.descricao,
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 16,
                              color: Colors.grey
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        cartaoInfoPet('Idade', pet.idade.toString()),
                        cartaoInfoPet('Sexo', pet.sexo.toString()),
                        cartaoInfoPet('Cor', pet.cor.toString()),
                        cartaoInfoPet('ID', pet.id.toString()),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                    child: Text(
                      pet.bio,
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 16,
                          height: 1.5
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => FormEditarPetScreen(id: pet.id),
                  ),
                );
              },
              child: Icon(
                  Icons.edit
              ),
              backgroundColor: Colors.redAccent,
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: CustomNavbar(paginaAberta: 0, pet: pet,),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<Pet> _getPet(int id) async {
    return await service.getPet(id);
  }
}
