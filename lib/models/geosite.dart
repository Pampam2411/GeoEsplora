class Geosite {
  final String id;
  final String name;
  final String location;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final String description;
  final String duration;
  final String distance;
  final String price;
  final bool isAccessible;
  final List<String> rockIds;
  final List<String>? galleryImages;

  Geosite({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.duration,
    required this.distance,
    required this.price,
    required this.isAccessible,
    this.rockIds = const [],
    this.galleryImages,
  });

  Geosite copyWith({
    String? id,
    String? name,
    String? location,
    String? imageUrl,
    double? rating,
    int? reviewCount,
    String? description,
    String? duration,
    String? distance,
    String? price,
    bool? isAccessible,
    List<String>? rockIds,
  }) {
    return Geosite(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      distance: distance ?? this.distance,
      price: price ?? this.price,
      isAccessible: isAccessible ?? this.isAccessible,
      rockIds: rockIds ?? this.rockIds,
    );
  }
}
