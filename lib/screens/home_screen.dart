import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Search Images with Pixabay'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // TextField(
          //   controller: _controller,
          //   textInputAction: TextInputAction.search,
          //   onSubmitted: (value) => searchModule.search(value),
          //   decoration: InputDecoration(
          //     hintText: "Enter a query",
          //     prefixIcon: IconButton(
          //       onPressed: () => _controller.clear(),
          //       icon: Icon(Icons.clear),
          //     ),
          //     suffixIcon: IconButton(
          //       onPressed: () {
          //         FocusScope.of(context).requestFocus(FocusNode());
          //         searchModule.search(_controller.text);
          //       },
          //       icon: Icon(Icons.search),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
