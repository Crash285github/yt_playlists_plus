class Video {
  String id;
  String title;
  String author;
  String thumbnailUrl;

  ///Modifies it's parent `playlist`
  ///
  ///If the video is missing, it is a `remove` function
  ///
  ///If the video is added, it is an `add` function
  ///
  ///Else it is null
  late bool Function()? function;

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
