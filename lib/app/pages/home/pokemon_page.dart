import 'package:api_pokemon/app/data/models/pokemon_model.dart';
import 'package:flutter/material.dart';

class PokemonPage extends StatelessWidget {
  final PokemonModel pokemon;

  const PokemonPage({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pokemon.nome.toUpperCase(),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white, // Define a cor personalizada do ícone.
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(
              pokemon.sprite,
              width: 300,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.none,
            ),
            Text(
              pokemon.nome,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
