class Video {
  String id;
  String title;
  String author;
  String thumbnailUrl;
  late bool Function(Video) modifyParentList;

  Video({
    required this.id,
    required this.title,
    required this.author,
    required this.thumbnailUrl,
  });

  @override
  String toString() {
    return "\nVideo(title: $title, author: $author)";
  }

  @override
  bool operator ==(other) => other is Video && id == other.id;

  @override
  int get hashCode => Object.hash(id, title);
}
