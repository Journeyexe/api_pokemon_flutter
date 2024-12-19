import 'package:api_pokemon/app/data/http/http_client.dart';
import 'package:api_pokemon/app/data/repositories/pokemon_repository.dart';
// import 'package:api_pokemon/app/pages/home/pokemon_page.dart';
import 'package:api_pokemon/app/pages/home/store/pokemon_store.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PokemonStore store = PokemonStore(
      repository: PokemonRepository(
    client: HttpClient(),
  ));

  @override
  void initState() {
    super.initState();
    store.getPokemon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PokeAPI",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: AnimatedBuilder(
          animation: Listenable.merge([
            store.isLoading,
            store.erro,
            store.state,
          ]),
          builder: (context, child) {
            if (store.isLoading.value == true) {
              return const Center(child: CircularProgressIndicator());
            }

            if (store.erro.value.isNotEmpty) {
              return Center(
                child: Text(
                  store.erro.value,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }

            if (store.state.value.isEmpty) {
              return const Center(
                child: Text(
                  'Tem nada aqui nao chefe',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 32,
                ),
                padding: const EdgeInsets.all(16),
                itemCount: store.state.value.length,
                itemBuilder: (_, index) {
                  final item = store.state.value[index];
                  return Column(
                    children: [
                      ClipRRect(
                        // borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          item.sprite,
                          fit: BoxFit.contain,
                          width: 300,
                          filterQuality: FilterQuality.none,
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Center(
                          child: Text(
                            item.nome,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        onTap: () {
                          context.push('/pokemon', extra: item);
                        },
                      )
                    ],
                  );
                },
              );
            }
          }),
    );
  }
}
