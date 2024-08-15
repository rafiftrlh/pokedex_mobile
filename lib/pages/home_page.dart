import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_mobile_new/models/pokemon.dart';
import 'package:pokedex_mobile_new/pages/favorites_page.dart';
import 'package:pokedex_mobile_new/widgets/pokemon_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Pokemon> pokemonList = [];
  List<Pokemon> filteredPokemonList = [];
  List<Pokemon> favoritePokemonList = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  Future<void> fetchPokemon() async {
    try {
      final response = await http
          .get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=20'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Pokemon> tempList = [];

        for (var item in data['results']) {
          final detailResponse = await http.get(Uri.parse(item['url']));
          if (detailResponse.statusCode == 200) {
            final detailData = json.decode(detailResponse.body);
            tempList.add(Pokemon.fromJson(detailData));
          }
        }

        setState(() {
          pokemonList = tempList;
          filteredPokemonList = pokemonList;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('An error occurred: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPokemon().catchError((error) {
      print('Error in initState: $error');
      setState(() {
        isLoading = false;
      });
    });
    searchController.addListener(() {
      filterPokemonList();
    });
  }

  void filterPokemonList() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredPokemonList = pokemonList.where((pokemon) {
        return pokemon.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  void toggleFavorite(Pokemon pokemon) {
    setState(() {
      pokemon.isMyFav = !pokemon.isMyFav;
      if (pokemon.isMyFav) {
        favoritePokemonList.add(pokemon);
      } else {
        favoritePokemonList.remove(pokemon);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 20,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              iconSize: 30,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FavoritesPage(favoritePokemonList: favoritePokemonList),
                  ),
                );
              },
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
          ),
        ],
        title: Container(
          height: 45,
          child: TextField(
            controller: searchController,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              filled: true,
              fillColor: Colors.grey.shade200,
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none),
              hintText: "Search Pokémon",
              hintStyle: TextStyle(fontSize: 14),
            ),
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: filteredPokemonList.length,
              itemBuilder: (context, index) {
                return PokemonComponent(
                  pokemon: filteredPokemonList[index],
                  toggleFavorite: toggleFavorite,
                );
              },
            ),
    );
  }
}
