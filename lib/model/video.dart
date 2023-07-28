class Video {
  String id, title, author, thumbnailUrl;

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

  ///Converts a `json` Object into a `Video` Object
  Video.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        author = json['author'],
        thumbnailUrl = json['thumbnailUrl'];

  ///Converts a `Video` Object into a `json` Object
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'thumbnailUrl': thumbnailUrl,
      };
}
