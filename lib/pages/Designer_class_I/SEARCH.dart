import 'package:flutter/material.dart';
import 'package:instagram/pages/Designer_class_I/ErrorPrinter.dart';

import 'package:instagram/pages/firebase_service/search_service.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SearchUI extends StatelessWidget {
  late double width;
  late double height;
  late BuildContext context;

  late List<Map<String, String>> userMapEmails = [];

  SearchUI({
    super.key,
    required this.width,
    required this.height,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: designedSearch());
    //return Center(child: Column(children: [SearchBoxUI(), DesignedButton()]));
  }

  /*
  Widget SearchBoxUI() {
    return Container(
      alignment: Alignment.center,
      width: width * 0.9,
      height: (height * 0.5) * 0.134,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black54),
        borderRadius: BorderRadius.circular(width * 0.04),
      ),

      child: TextField(
        onTap: () async {
          final instance = Provider.of<SearchService>(context, listen: false);
          List<String> userEmails = (await instance.getUserDetails());
          userEmails.sort();
          await showSearch(
            context: context,
            delegate: MySearchDelegate(list: userEmails),
          );
        },
        decoration: InputDecoration(
          labelText: "search",
          labelStyle: TextStyle(
            color: const Color.fromARGB(255, 59, 58, 58),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          border: InputBorder.none,
          prefixIcon: GestureDetector(
            onTap: () {},
            child: Icon(Icons.search, size: width * 0.065),
          ),
          contentPadding: EdgeInsets.only(left: 10),
        ),
      ),
    );
  }
  
  Widget SearchBoxUI() {
    return ElevatedButton(
      onPressed: () async {
        bool result = await SearchService().AddFriend(
          "c8Kx5chgU3YSUiuVZOp4gQ602fe2",
          "frienduid",
        );
        print("${ErrorPrinter.green} $result ${ErrorPrinter.reset}");
      },
      child: Text("Add"),
    );
  }
  */

  Widget designedSearch() {
    return GestureDetector(
      onTap: () async {
        final instance = Provider.of<SearchService>(context, listen: false);
        userMapEmails = await instance.get_User_With_UID_Email();
        List<String> userEmails = [];

        for (var map in userMapEmails) {
          for (var data in map.keys) {
            userEmails.add(data);
          }
        }

        userEmails.sort();
        await showSearch(
          context: context,
          delegate: MySearchDelegate(
            suggestions: userEmails,
            otherDetails: userMapEmails,
          ),
        );
      },
      child: Container(
        alignment: Alignment.centerLeft,
        width: width * 0.9,
        height: (height * 0.5) * 0.134,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border.all(width: 1, color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(width * 0.04),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(2, 2),
              blurRadius: 1,
              spreadRadius: 0,
              color: Colors.grey.shade400,
            ),
          ],
        ),

        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Icon(Icons.search),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Text(
                "search",
                style: TextStyle(
                  color: const Color.fromARGB(255, 59, 58, 58),
                  fontFamily: "Outfit",
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  late List<String> suggestions;
  late List<Map<String, String>> otherDetails;
  MySearchDelegate({required this.suggestions, required this.otherDetails});

  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
      onPressed: () {
        if (query == '') {
          close(context, null);
        } else {
          query = '';
        }
        FocusScope.of(context).unfocus();
      },
      icon: Icon(Icons.clear),
    ),
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    onPressed: () {
      close(context, null);
      FocusScope.of(context).unfocus();
    },
    icon: Icon(Icons.arrow_back_ios),
  );

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text(
          "No Results found",
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
      );
    } else {
      return Center(
        child: Text(
          "No Users found",
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionResult =
        suggestions.where((resultMatch) {
          final result = resultMatch.toLowerCase();
          final input = query.toLowerCase();
          return result.contains(input);
        }).toList();

    return ListView.builder(
      itemCount: suggestionResult.length,
      itemBuilder: (context, index) {
        final sug = suggestionResult[index];

        return Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 0.75, color: Colors.black12),
            ),
          ),
          child: ListTile(
            title: Text(
              sug,
              style: TextStyle(
                color: const Color.fromARGB(255, 59, 58, 58),
                fontFamily: "Outfit",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            trailing: Container(
              decoration: BoxDecoration(),
              child: ElevatedButton(
                onPressed: () async {
                  final instance = Provider.of<SearchService>(
                    context,
                    listen: false,
                  );
                  String currentuid = instance.GetCurrentUserUID()!;
                  String otheruid = "";

                  for (Map<String, String> dataMap in otherDetails) {
                    for (String dataString in dataMap.keys) {
                      if (dataString == sug) {
                        otheruid = dataMap[dataString]!;
                      }
                    }
                  }

                  bool result = await instance.Add_Friend(currentuid, otheruid);

                  if (result) {
                    print("${ErrorPrinter.green} Added ${ErrorPrinter.reset}");
                  } else {
                    print("${ErrorPrinter.red} already ${ErrorPrinter.reset}");
                  }
                },
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "+ ",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "friend",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


/*

  late bool? isDecoration;
  late bool? isTextDecoration;
  late bool? isBorderNeed;
  late BoxDecoration? boxdecoration;
  late TextStyle? textstyle;
  late int? borderWidth;
  late MaterialAccentColor? color; */