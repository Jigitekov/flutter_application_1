class PhotoModel {
  final String id;
  final String description;
  final String imageUrl;
  final String user;

  PhotoModel({
    required this.id,
    required this.description,
    required this.imageUrl,
    required this.user,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'],
      description: json['description'] ?? json['alt_description'] ?? 'No description',
      imageUrl: json['urls']['regular'],
      user: json['user']['name'],
    );
  }
}