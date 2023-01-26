import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<String> SearchTerms = [
    'Jeans',
    'Shirt',
    'T-Shirt',
    'Coat',
    'Pants',
    'Jacket',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () => query = '', icon: Icon(Icons.clear))];
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var match in SearchTerms) {
      if (match.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(match);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var match in SearchTerms) {
      if (match.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(match);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: Icon(Icons.arrow_back),
    );
  }
}
