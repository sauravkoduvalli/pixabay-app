class AlbumPhoto {
  final int? id;
  final List<Photo> photos;

  AlbumPhoto({
    required this.id,
    required this.photos,
  });

  factory AlbumPhoto.fromJson(Map<String, dynamic> json) {
    var photos = List<Map>.from(json["hits"].map((x) => x))
        .map((x) => Photo(id: x['id'], url: x['webformatURL']))
        .toList();
    return AlbumPhoto(
      id: json['id'],
      photos: photos,
    );
  }
}

class Photo {
  final int id;
  final url;
  Photo({
    required this.id,
    required this.url,
  });
}
