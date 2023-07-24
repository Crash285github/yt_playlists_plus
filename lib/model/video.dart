class Video {
  String id;
  String title;
  String author;
  String thumbnailUrl;

  Video({
    required this.id,
    required this.title,
    required this.author,
    required this.thumbnailUrl,
  });

  @override
  String toString() {
    return "Video(id: $id, title: $title, author: $author, thumbnailUrl: $thumbnailUrl)";
  }

  @override
  bool operator ==(other) => other is Video && id == other.id;

  @override
  int get hashCode => Object.hash(id, title);
}
