import 'package:flutter/material.dart';
import 'package:sistematizacao_dmm/lista.dart';
import 'package:sistematizacao_dmm/pesquisa.dart';

class AppHome extends StatelessWidget {
  const AppHome({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  List<Widget> tabs = [
    PesquisaMoedas(),
    Lista()



  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('HomePage'),
          centerTitle: true
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Pesquisa diária',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Pesquisa quinzenal',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(
                () {
              _selectedIndex = index;
            },
          );
        },
      ),
      body: Center(
        child: tabs.elementAt(_selectedIndex),
      ),
    );
  }


}