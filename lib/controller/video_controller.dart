import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/enums/video_status.dart';
import 'package:yt_playlists_plus/model/video.dart';

class VideoController extends ChangeNotifier {
  final Video video;
  String get id => video.id;
  String get title => video.title;
  set title(String value) {
    video.title = value;
    notifyListeners();
  }

  String get author => video.author;
  set author(String value) {
    video.author = value;
    notifyListeners();
  }

  String get thumbnailUrl => video.thumbnailUrl;
  set thumbnailUrl(String value) {
    video.thumbnailUrl = value;
    notifyListeners();
  }

  ///The video's current status
  VideoStatus get status => _status;
  VideoStatus _status = VideoStatus.normal;
  set status(VideoStatus newStatus) {
    _status = newStatus;
    notifyListeners();
  }

  ///What the Video should do when tapped on it's Widget
  ///
  ///The add/remove functions are assigned usually
  Function()? onTap;

  ///Video's extra fucntion based on it's status
  ///
  ///Missing: add to planned
  Function? statusFunction;

  VideoController({required this.video});

  ///Creates a copy if a Video
  factory VideoController.deepCopy(VideoController source) =>
      VideoController(video: Video.deepCopy(source.video));

  @override
  String toString() => video.toString();

  @override
  bool operator ==(other) => other is VideoController && id == other.id;

  @override
  int get hashCode => Object.hash(id, null);

  ///Converts a `json` Object into a `VideoController` Object
  VideoController.fromJson(Map<String, dynamic> json)
      : video = Video.fromJson(json);

  ///Converts a `VideoController` Object into a `json` Object
  Map<String, dynamic> toJson() => video.toJson();
}
