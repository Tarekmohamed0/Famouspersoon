class FamousPersonModel {
  final int id;
  final String name;
  final String imageUrl;
  final String? knownForDepartment;
  final String popularity;
  final String knownFor;
  final String birthday;
  final String placeOfBirth;
  final String biography;
  final String movieImage;

  FamousPersonModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.knownForDepartment,
    required this.popularity,
    required this.knownFor,
    required this.birthday,
    required this.placeOfBirth,
    required this.biography,
    required this.movieImage,
  });

  /// Factory constructor to create an instance of FamousPersonModel from JSON
  factory FamousPersonModel.fromJson(Map<String, dynamic> json) {
    const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';
    String imagePath = json['profile_path'] ?? '';
    String movieImagePath =
        (json['known_for'] != null && json['known_for'].isNotEmpty)
            ? json['known_for'][0]['poster_path'] ?? ''
            : '';

    // Image URLs
    String imageUrl = imagePath.isNotEmpty
        ? '$baseImageUrl$imagePath'
        : 'https://via.placeholder.com/150';
    String movieImage = movieImagePath.isNotEmpty
        ? '$baseImageUrl$movieImagePath'
        : 'https://via.placeholder.com/150';

    return FamousPersonModel(
      id: json['id'],
      name: json['name'] ?? 'Unknown',
      imageUrl: imageUrl,
      knownForDepartment: json['known_for_department'] ?? 'Unknown',
      popularity: json['popularity']?.toString() ?? 'Unknown',
      knownFor: (json['known_for'] != null && json['known_for'].isNotEmpty)
          ? json['known_for'][0]['title'] ?? 'Unknown'
          : 'Unknown',
      birthday: json['birthday'] ?? 'Unknown',
      placeOfBirth: json['place_of_birth'] ?? 'Unknown',
      biography: json['biography'] ?? 'Unknown',
      movieImage: movieImage,
    );
  }
}
