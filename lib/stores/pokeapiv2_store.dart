import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:pokedex/consts/consts_api.dart';
import 'package:pokedex/models/especie.dart';
import 'package:pokedex/models/poke_api_v2.dart';

import 'package:http/http.dart' as http;
part 'pokeapiv2_store.g.dart';

class PokeApiV2Store = _PokeApiV2StoreBase with _$PokeApiV2Store;

abstract class _PokeApiV2StoreBase with Store {

  @observable 
  Especie specie;

  @observable 
  PokeApiV2 pokeApiV2;

  @action 
  Future<void> getInfoPokemon(String nome) async {
    try {
      final response = await http.get(ConstsAPI.pokeapiv2URL+nome.toLowerCase());
      var decodeJson = jsonDecode(response.body);
      pokeApiV2 = PokeApiV2.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print("Erro ao carregar lista" + stacktrace.toString());
      return null;
    }
  }

  @action
  Future<void> getInfoSpecie(String numPokemon) async {
    try {
      specie = null;
      final response = await http.get(ConstsAPI.pokeapiv2EspeciesURL+numPokemon);
      var decodeJson = jsonDecode(response.body);
      var _specie = Especie.fromJson(decodeJson);
      specie = _specie;
    } catch (error, stacktrace) {
      print("Erro ao carregar lista" + stacktrace.toString());
      return null;
    }
  }

}