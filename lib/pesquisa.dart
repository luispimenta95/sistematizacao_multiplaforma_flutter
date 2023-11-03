import 'package:flutter/material.dart';
import 'package:sistematizacao_dmm/controller/api.dart';

import 'custom_search_delegate.dart';

class PesquisaMoedas extends StatefulWidget {
  @override
  _StatePesquisa createState() => _StatePesquisa();
}

class _StatePesquisa extends State<PesquisaMoedas> {
  String _data = 'Loading...';
  String name = '';
  String maiorCotacao ='';
  String menorCotacao = '';
  bool isLoading = true;

  final ApiMonetizacao api = new ApiMonetizacao();





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Demo'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(api.sugestoesPesquisa()),
              );
            },
          ),
        ],
      ),

      body: ListView.builder(
        itemCount: api.sugestoesPesquisa().length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(api.sugestoesPesquisa()[index]),
            onTap: (){
              showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(api.sugestoesPesquisa())
              );
            },
          );
        },
      ),
    );
  }
}