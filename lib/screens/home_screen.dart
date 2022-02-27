import 'package:flutter/material.dart';
import 'package:pixabay_machine_test/models/album_photo_model.dart';
import 'package:pixabay_machine_test/screens/detailed_screen.dart';
import 'package:pixabay_machine_test/screens/search_module.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  final searchModule = SearchModule();

  void clearSearchText() {
    searchController.clear();
  }

  @override
  void initState() {
    super.initState();
    searchModule.search(searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Pixabay Images'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      // body conatins two widgets mainly, searchbar and image grid
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // search bar widget
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: TextField(
              controller: searchController,
              textInputAction: TextInputAction.search,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                setState(() {});
              },
              onSubmitted: (value) => searchModule.search(value),
              decoration: InputDecoration(
                hintText: "Search here...",
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(30),
                ),
                prefixIcon: searchController.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          clearSearchText();
                        },
                      ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    searchModule.search(searchController.text);
                  },
                ),
              ),
            ),
          ),

          // used stream builder to get image data into this widget.
          // As its is expanded, when more data streams, it provide a lazy-loading view.
          Expanded(
            child: StreamBuilder<AlbumPhoto>(
                stream: searchModule.stream,
                builder:
                    (BuildContext context, AsyncSnapshot<AlbumPhoto> snapshot) {
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
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return DetailScreen(
                                imageData: photo.url,
                              );
                            }));
                          },
                          child: GridTile(
                            child: Image.network(
                              photo.url,
                              fit: BoxFit.cover,
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
                }),
          ),
        ],
      ),
    );
  }
}
