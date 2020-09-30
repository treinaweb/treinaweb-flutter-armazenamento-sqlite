import 'dart:math';

import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/utils/db_util.dart';

class PetService {
  List<Pet> _petList = [];

  Future<List> getAllPets() async {
    final dataList = await DbUtil.getData('pets');
    _petList = dataList.map((pets) => Pet.fromMap(pets)).toList();
    return _petList;
  }

  void addPet(Pet pet){
    DbUtil.insertData('pets', pet.toMap());
  }

  // void editPet(int id, Pet newPet) {
  //   Pet petEditar = getPet(id);
  //   petEditar.nome = newPet.nome;
  //   petEditar.descricao = newPet.descricao;
  //   petEditar.idade = newPet.idade;
  //   petEditar.sexo = newPet.sexo;
  //   petEditar.cor = newPet.cor;
  //   petEditar.bio = newPet.bio;
  // }

  Future<Pet> getPet(int id) async {
    List<String> colunas = [
      "id",
      "nome",
      "idade",
      "imageUrl",
      "descricao",
      "sexo",
      "cor",
      "bio"
    ];
    String whereString = "id = ?";
    List<dynamic> whereArgumento = [id];
    final dataList = await DbUtil.getDataWhere('pets', colunas,
        whereString, whereArgumento);
    return Pet.fromMap(dataList.first);

  }
}