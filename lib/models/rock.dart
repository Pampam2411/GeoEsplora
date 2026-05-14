class Rock {
  final String id;
  final String name;
  final String type;
  final String imageUrl;
  final String geologicalEra;
  final String description;
  final double porosity;
  final double resistence;
  final double density;
  final List<String>? recognitionImages;

  Rock({
    required this.id,
    required this.name,
    required this.type,
    required this.imageUrl,
    required this.geologicalEra,
    required this.description,
    required this.density,
    required this.porosity,
    required this.resistence,
    this.recognitionImages,
  });
}
