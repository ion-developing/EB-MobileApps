class Post {
  final int id;
  final String title;
  final String poster;

  Post({required this.id, required this.title, required this.poster});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      poster: json['poster'],
    );
  }
}
