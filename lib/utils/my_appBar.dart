import 'package:flutter/material.dart';



class MyAppBar extends StatelessWidget implements PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        titulo,
        style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold,
          shadows: <Shadow>[

            Shadow(
              offset: Offset(2.0, 2.0),
              blurRadius: 6.0,
              color: Colors.purple,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,


    );
  }

  String titulo;

  MyAppBar({super.key, String this.titulo = "DecoDE"});

  @override
  // Implementa o getter required preferredSize da PreferredSizeWidget
  // Retorna o tamanho padrão de uma AppBar
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}