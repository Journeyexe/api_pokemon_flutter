class PokemonType {
  final String name;
  final String url;

  PokemonType({
    required this.name,
    required this.url,
  });

  factory PokemonType.fromMap(Map<String, dynamic> map) {
    return PokemonType(
      name: map['type']['name'],
      url: map['type']['url'],
    );
  }
}

class PokemonModel {
  final String nome;
  final String sprite;
  final String shiny;
  final List<PokemonType> tipos;

  PokemonModel({
    required this.nome,
    required this.sprite,
    required this.shiny,
    required this.tipos,
  });

  factory PokemonModel.fromMap(Map<String, dynamic> map) {
    return PokemonModel(
      nome: map['name'],
      sprite: map['sprites']['versions']['generation-v']['black-white']['animated']['front_default'],
      shiny: map['sprites']['versions']['generation-v']['black-white']['animated']['front_shiny'],
      tipos: (map['types'] as List<dynamic>)
          .map((type) => PokemonType.fromMap(type))
          .toList(),
    );
  }
}
