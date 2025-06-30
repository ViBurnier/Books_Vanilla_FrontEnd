import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  myListTile(String texto, String page, context){
    return ListTile(
      title: Text(texto, style: TextStyle(color: Colors.white, fontSize: 20),),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, page);
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Drawer(
      backgroundColor: Colors.redAccent,
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child:
            Text("DEcoDE", style: TextStyle(color: Colors.white, fontSize: 20),),
          ),
          myListTile("cadastro", "/cadastro", context),
          myListTile("detalhes", "/detalhes", context),
          myListTile("contato", "/contato", context),
          myListTile("sobre", "/sobre", context),
        ],

      ),

    );

  }
}