import 'package:flutter/material.dart';

class Searchpage extends StatefulWidget {
  @override
  State<Searchpage> createState() => _Searchpage();
}

class _Searchpage extends State<Searchpage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 80,
          title: const Text(
            'PETRA',
            style: TextStyle(
              fontFamily: 'TrajanPro',
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0),
                ),
                onTap: () {
                  controller.openView();
                },
                onChanged: (_) {
                  controller.openView();
                },
                leading: const Icon(Icons.search),
              );
            },
            suggestionsBuilder: (BuildContext context, SearchController controller) {
              return List<ListTile>.generate(5, (int index) {
                final String item = 'item $index';
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    setState(() {
                      controller.closeView(item);
                    });
                  },
                );
              });
            },
          ),
        ),
      ),
    );
  }
}
