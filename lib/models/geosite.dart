class Geosite {
  final String id,
      name,
      location,
      imageUrl,
      description,
      duration,
      distance,
      price,
      surface,
      route,
      slope,
      steps,
      wheelchair;
  final double rating, latitude, longitude;
  final int reviewCount;
  final bool isAccessible;
  final List<String> rockIds;
  final List<String>? galleryImages;

  Geosite({
    required this.id,
    required this.name,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.duration,
    required this.distance,
    required this.price,
    required this.isAccessible,
    required this.surface,
    required this.route,
    required this.slope,
    required this.steps,
    required this.wheelchair,

    this.rockIds = const [],
    this.galleryImages,
  });

  Geosite copyWith({
    String? id,
    String? name,
    String? location,
    double? latitude,
    double? longitude,
    String? imageUrl,
    double? rating,
    int? reviewCount,
    String? description,
    String? duration,
    String? distance,
    String? price,
    bool? isAccessible,
    String? route,
    String? surface,
    String? slope,
    String? steps,
    String? wheelchair,
    List<String>? rockIds,
  }) {
    return Geosite(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      distance: distance ?? this.distance,
      price: price ?? this.price,
      isAccessible: isAccessible ?? this.isAccessible,
      rockIds: rockIds ?? this.rockIds,
      route: route ?? this.route,
      slope: slope ?? this.slope,
      surface: surface ?? this.surface,
      steps: steps ?? this.steps,
      wheelchair: wheelchair ?? this.wheelchair,
    );
  }
}
