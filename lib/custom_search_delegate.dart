import 'package:flutter/material.dart';
import 'package:sistematizacao_dmm/controller/api.dart';


class CustomSearchDelegate extends SearchDelegate<String> {
  final List<String> items;
  final ApiMonetizacao api = new ApiMonetizacao();


  CustomSearchDelegate(this.items);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(context) {
    return FutureBuilder<String>(
        future: api.pesquisarApi(query),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.toLowerCase() == 'ok') {
              return ListView(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.currency_exchange),
                    title: Text(api.name),
                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_circle_up),
                    title: Text(api.maiorCotacao),
                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_circle_down),
                    title: Text(api.menorCotacao),
                  ),
                ],
              );
            } else {
              return ListView(
                children: <Widget>[

                 Center(
                   child: Text(
                     'Nenhum moeda com o nome $query foi encontrada!'
                   ),
                 )
                ],
              );
            }
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> suggestions = query.isEmpty
        ? []
        : items
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            // Update the search query when an option is clicked
            query = suggestions[index];

            // Close the search and display the selected item
            showResults(context);
          },
        );
      },
    );
  }
}
