import 'package:flutter/material.dart';
import 'package:pokedex_mobile_new/models/pokemon.dart';
import 'package:pokedex_mobile_new/pages/pokemon_detail_page.dart';

class PokemonComponent extends StatelessWidget {
  final Pokemon pokemon;
  final Function(Pokemon) toggleFavorite;

  const PokemonComponent({
    Key? key,
    required this.pokemon,
    required this.toggleFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PokemonDetailPage(pokemon: pokemon),
          ),
        );
      },
      child: Container(
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
            Spacer(),
            IconButton(
              icon: Icon(
                pokemon.isMyFav ? Icons.favorite : Icons.favorite_border,
                color: pokemon.isMyFav ? Colors.red : Colors.grey,
              ),
              onPressed: () => toggleFavorite(pokemon),
            ),
          ],
        ),
      ),
    );
  }
}
