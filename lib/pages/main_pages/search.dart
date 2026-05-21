import 'package:flutter/material.dart';

/*  S  E  A  R  C  H  ----  B  A  R  */
import 'package:instagram/pages/Designer_class_I/SEARCH.dart';

class Search extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchClass();
}

class SearchClass extends State<Search> {
  late double width, height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(height: (height * 0.5) * 0.25),
        Expanded(child: BuildSearchPage()),
      ],
    );
  }

  Widget BuildSearchPage() {
    return Column(
      children: [SearchUI(width: width, height: height, context: context)],
    );
  }
}
