import 'package:flutter/material.dart';
import 'package:pixabay_machine_test/screens/search_module.dart';
import 'package:pixabay_machine_test/widgets/image_view_widget.dart';

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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Image.asset(
          'assets/images/logo.png',
          width: 120.0,
          height: 100.0,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      // body conatins two widgets mainly, searchbar and image grid
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // search bar widget
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: TextField(
              controller: searchController,
              textInputAction: TextInputAction.search,
              keyboardType: TextInputType.text,
              onSubmitted: (value) => searchModule.search(value),
              decoration: InputDecoration(
                hintText: "Search here...",
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(10),
                ),
                // if user type a search item,
                // then shows clear icon to remove the text.
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
          // Extracted to widgets folder
          ImageViewWidget(searchModule: searchModule),
        ],
      ),
    );
  }
}
