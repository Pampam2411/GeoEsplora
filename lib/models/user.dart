class AppUser {
  final String id;
  final String name;
  final String email;
  final String profileImageUrl;
  final List<String> favoriteGeositeIds;
  final List<String> visitedGeositeIds;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    this.profileImageUrl = '',
    this.favoriteGeositeIds = const [],
    this.visitedGeositeIds = const [],
  });

  AppUser copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImageUrl,
    List<String>? favoriteGeositeIds,
    List<String>? visitedGeositeIds,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      favoriteGeositeIds: favoriteGeositeIds ?? this.favoriteGeositeIds,
      visitedGeositeIds: visitedGeositeIds ?? this.visitedGeositeIds,
    );
  }
}
