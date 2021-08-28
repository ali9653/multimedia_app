import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:multimedia_app/models/photos.dart';
import 'package:multimedia_app/models/videos.dart';

class ApiService {
  static final String _photosBaseURL = "https://api.pexels.com/v1/curated?";
  static final String _authorizationKey = "563492ad6f917000010000014cf3be4e34a94fb2b2e838af4966e8ba";
  static final String _videosBaseURL = "https://api.pexels.com/videos/popular?";

  // decode photos
  static List<Photo> getPhotosList(String responseBody) {
    Map<String, dynamic> json = jsonDecode(responseBody);
    List<dynamic> body = json['photos'];
    List<Photo> photos = body.map((e) => Photo.fromJson(e)).toList();
    return photos;
  }

  // decode videos
  static List<Video> getVideosList(String responseBody) {
    Map<String, dynamic> json = jsonDecode(responseBody);
    List<dynamic> body = json['videos'];
    List<Video> videos = body.map((e) => Video.fromJson(e)).toList();
    return videos;
  }

  // fetch photos
  static Future<List<Photo>?> getPhotos(int page) async {
    try {
      var response = await http.get(Uri.parse("${_photosBaseURL}per_page=14&page=$page"), headers: {"Authorization": _authorizationKey});
      if (response.statusCode == 200) {
        //print("got photos");
        return getPhotosList(response.body);
      } else {
        //print("no photos");
        return <Photo>[];
      }
    } on SocketException {
     // print("no internet");
      return null;
    }
  }

  // fetch videos
  static Future<List<Video>?> getVideos(int page) async {
    try {
      var response = await http.get(Uri.parse("${_videosBaseURL}per_page=15&page=$page"), headers: {"Authorization": _authorizationKey});
      if (response.statusCode == 200) {
       // print("got videos");
        return getVideosList(response.body);
      } else {
       // print("no videos");
        return <Video>[];
      }
    } on SocketException {
      //print("no internet");
      return null;
    }
  }
}
