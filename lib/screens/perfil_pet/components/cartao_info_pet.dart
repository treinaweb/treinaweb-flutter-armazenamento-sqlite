import 'package:flutter/material.dart';

Widget cartaoInfoPet(String label, String informacao) {
  return Container(
    margin: EdgeInsets.all(10),
    width: 100,
    decoration: BoxDecoration(
        color: Color(0xFFF8F2F7),
        borderRadius: BorderRadius.circular(20)
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.red
          ),
        ),
        SizedBox(height: 8,),
        Text(
          informacao,
          style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black
          ),
        ),
      ],
    ),
  );
}