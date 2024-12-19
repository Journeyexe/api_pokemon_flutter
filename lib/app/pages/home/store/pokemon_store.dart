import 'package:api_pokemon/app/data/http/exceptions.dart';
import 'package:api_pokemon/app/data/models/pokemon_model.dart';
import 'package:api_pokemon/app/data/repositories/pokemon_repository.dart';
import 'package:flutter/material.dart';

class PokemonStore {

  final IPokemonRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<PokemonModel>> state = ValueNotifier<List<PokemonModel>>([]);

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  PokemonStore({required this.repository});

  Future getPokemon() async {
    isLoading.value = true;

    try{
      final result = await repository.getPokemon();
      state.value = result;
    }on NotFoundException catch(e){
      erro.value = e.message;
    }catch(e){
      erro.value = e.toString(); 
    }

    isLoading.value = false;
  }
}