class Pokemon {
  Pokemon({
    required this.name,
    required this.level,
    required this.imageURL,
    required this.skills,
  });

  final String name;
  final int level;
  final String imageURL;
  final List<String> skills;
}
