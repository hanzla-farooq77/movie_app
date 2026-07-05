class CastModel {
  final int id;
  final String name;
  final String character;
  final String profilePath;
  final double popularity;

  CastModel({
    required this.id,
    required this.name,
    required this.character,
    required this.profilePath,
    required this.popularity,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      character: json['character'] ?? '',
      profilePath: json['profile_path'] ?? '',
      popularity: (json['popularity'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'character': character,
      'profile_path': profilePath,
      'popularity': popularity,
    };
  }
}