import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:pixabay_machine_test/models/album_photo_model.dart';
import 'dart:convert';

class SearchModule {
  static const apiKey = "25895666-7bfba378b46f7f77026a1bc10";
  final controller = StreamController<AlbumPhoto>.broadcast();

  // Input stream. We add our results to the stream using this variable.
  StreamSink<AlbumPhoto> get sink => controller.sink;

  // Output stream. This one will be used within our page to display the results.
  Stream<AlbumPhoto> get stream => controller.stream;

  Future<AlbumPhoto> fetchAlbumPhoto(String searchTerm) async {
    var url = Uri.encodeFull(
        'https://pixabay.com/api/?key=$apiKey&q=$searchTerm&image_type=photo');
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return AlbumPhoto.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  void search(String searchTerm) async {
    AlbumPhoto album = await fetchAlbumPhoto(searchTerm);
    sink.add(album);
  }
}
