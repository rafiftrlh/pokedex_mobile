import 'package:flutter/material.dart';
import 'package:pokedex_mobile_new/models/pokemon.dart';

class FavoritesPage extends StatelessWidget {
  final List<Pokemon> favoritePokemonList;

  const FavoritesPage({Key? key, required this.favoritePokemonList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: favoritePokemonList.isEmpty
          ? Center(child: Text('No favorites yet.'))
          : ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: favoritePokemonList.length,
              itemBuilder: (context, index) {
                final pokemon = favoritePokemonList[index];
                return Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ]),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(pokemon.image),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pokemon.name,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 5),
                          Text(
                            pokemon.category,
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
