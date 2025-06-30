import 'package:flutter/material.dart';
import 'my_drawer.dart';

class MyFooter extends StatelessWidget{
  const MyFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white, // Cor de fundo do BottomAppBar
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // Distribui os itens uniformemente
        children: <Widget>[
          IconButton(
            // Cor do ícone
            color: Colors.black,
            // Ao passar mouse
            hoverColor: Colors.deepPurple,
            // Ao pressionar
            highlightColor: Colors.white,
            // Ícone de casa
            icon: const Icon(Icons.home),
            // Tamanho do ícone
            iconSize: 30.0,
            // Ao para o moue, mostra o text
            tooltip: 'Página Inicial',
            // Navegar para a página inicial.
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.black,
            hoverColor: Colors.deepPurple,
            highlightColor: Colors.white,
            iconSize: 30.0,
            onPressed: () {
              Navigator.pushNamed(context, '/modelo');
            }, // onPressed
            tooltip: 'Pesquisar',
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            color: Colors.black,
            hoverColor: Colors.deepPurple,
            highlightColor: Colors.white,
            iconSize: 30.0,
            onPressed: () {

              Scaffold.of(context).openDrawer();
            }, // onPressed
            tooltip: 'mais',
          ),
        ], // children
      ), // Row
    ); // BottomAppBar
  }
}




