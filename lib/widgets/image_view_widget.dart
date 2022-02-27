import 'package:flutter/material.dart';
import 'package:pixabay_machine_test/models/album_photo_model.dart';
import 'package:pixabay_machine_test/screens/detailed_screen.dart';
import 'package:pixabay_machine_test/screens/search_module.dart';

class ImageViewWidget extends StatelessWidget {
  const ImageViewWidget({
    Key? key,
    required this.searchModule,
  }) : super(key: key);

  final SearchModule searchModule;

  @override
  Widget build(BuildContext context) {
    // used stream builder to get image data into this widget.
    // As its is expanded, when more data streams, it provide a lazy-loading view.
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: StreamBuilder<AlbumPhoto>(
          stream: searchModule.stream,
          builder: (BuildContext context, AsyncSnapshot<AlbumPhoto> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.photos.isEmpty) {
                return const Center(
                  child: Text("No data found!"),
                );
              }
              return GridView.count(
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                crossAxisCount: 2,
                children: snapshot.data!.photos.map((Photo photo) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return DetailScreen(
                          imageData: photo.url,
                        );
                      }));
                    },
                    child: GridTile(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          photo.url,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }
            // By default, show a loading spinner.
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
