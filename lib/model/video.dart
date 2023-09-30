class Video {
  ///The unique identifier of the Video
  final String id;

  ///The title of the Video
  String title;

  ///The author of the Video
  String author;

  ///The url of the thumbnail of the Video
  String thumbnailUrl;

  Video({
    required this.id,
    required this.title,
    required this.author,
    required this.thumbnailUrl,
  });

  ///Creates a deep copy of the source object
  factory Video.deepCopy(Video source) => Video(
        id: source.id,
        title: source.title,
        author: source.author,
        thumbnailUrl: source.thumbnailUrl,
      );

  @override
  String toString() => "\nVideo(title: $title, author: $author)";

  @override
  bool operator ==(other) => other is Video && id == other.id;

  @override
  int get hashCode => Object.hash(id, null);

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
