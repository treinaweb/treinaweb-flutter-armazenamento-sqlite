import 'package:flutter/material.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/screens/perfil_pet/perfil_pet_screen.dart';

Widget petCard(BuildContext context, int index, Pet pet) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => PerfilPetScreen(id: pet.id,),
        ),
      );
    },
    child: Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Hero(
            tag: pet.id,
            child: Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(20)
                  ),
                  image: DecorationImage(
                      image: AssetImage(pet.imageUrl),
                      fit: BoxFit.cover
                  )
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(12, 12, 40, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  pet.nome,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(12, 12, 40, 0),
            child: Text(
              pet.descricao,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  color: Colors.grey
              ),
            ),
          )
        ],
      ),
    ),
  );
}