import 'dart:math';

import 'package:lifepet_app/models/remedio_model.dart';
import 'package:lifepet_app/services/pet_service.dart';

class RemedioService{
  final List<Remedio> _remedioList = [];
  final PetService petService = PetService();

  List getRemediosPet(String id) {
    return _remedioList.where((remedio) {
      return remedio.pet.id == id;
    }).toList();
  }

  void addRemedio(Remedio remedio) {
    _remedioList.add(Remedio(
      nome: remedio.nome,
      data: remedio.data,
      id: Random().nextInt(100).toString(),
      pet: remedio.pet
    ));
  }
}