class Pokemon {
  final String name;
  final String image;
  final String category;
  final String weight;
  final String height;
  final List<String> abilities;
  bool isMyFav;

  Pokemon({
    required this.name,
    required this.image,
    required this.category,
    required this.weight,
    required this.height,
    required this.abilities,
    this.isMyFav = false,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      image: json['sprites']['front_default'],
      category: json['types'][0]['type']['name'],
      weight: json['weight'].toString(),
      height: json['height'].toString(),
      abilities: (json['abilities'] as List)
          .map((ability) => ability['ability']['name'] as String)
          .toList(),
    );
  }
}
