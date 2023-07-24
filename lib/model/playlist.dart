class Playlist {
  String id;
  String title;
  String author;
  String thumbnailUrl;

  Playlist({
    required this.id,
    required this.title,
    required this.author,
    required this.thumbnailUrl,
  });

  @override
  String toString() {
    return "Playlist(id: $id, title: $title, author: $author, thumbnailUrl: $thumbnailUrl)";
  }
}
