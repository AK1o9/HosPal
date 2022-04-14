import 'package:flutter/material.dart';

import '../../constants/style.dart';

class JobSearchPage extends StatefulWidget {
  const JobSearchPage({Key? key}) : super(key: key);

  @override
  State<JobSearchPage> createState() => _JobSearchPageState();
}

class _JobSearchPageState extends State<JobSearchPage> {
  String? searchQuery;

  final searchBarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchBarController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: light, //dark,
                  borderRadius: bRadius12,
                ),
                child: TextField(
                  controller: searchBarController,
                  cursorColor: dark, //light,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.search,
                        size: 25,
                        color: dark, //light,
                      ),
                      border: InputBorder.none,
                      hintText: 'Search for a job of your choice.',
                      hintStyle: TextStyle(color: /* light */ grey),
                      suffixIcon: searchBarController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                Icons.close,
                                color: dark,
                              ),
                              onPressed: () => searchBarController.clear(),
                            )
                          : Container(width: 0)),
                ),
              )),
            ],
          ),
        ],
      )),
    );
  }
}
