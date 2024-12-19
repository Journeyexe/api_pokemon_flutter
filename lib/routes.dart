import 'package:api_pokemon/app/data/models/pokemon_model.dart';
import 'package:api_pokemon/app/pages/home/home_page.dart';
import 'package:api_pokemon/app/pages/home/pokemon_page.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
      path: '/pokemon',
      builder: (context, state) {
        final pokemon = state.extra as PokemonModel;
        return PokemonPage(pokemon: pokemon);
      })
]);
