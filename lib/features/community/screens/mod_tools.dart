// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class ModTools extends StatelessWidget {
  final String name;
  const ModTools({
    super.key,
    required this.name,
  });
void navigateToEditScreen(context){
  Routemaster.of(context).push('/edit-community/$name');

}
void navigateToAddModsScreen(context){
  Routemaster.of(context).push('/add-mods/$name');

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Mod Tools'),

      ),
      body:Column(
        children: [
          ListTile(leading: const Icon(Icons.add_moderator),

            title: const Text('Add mods'),
            onTap: (){
              navigateToAddModsScreen(context);
            },
          ),
          ListTile(leading: const Icon(Icons.edit),
            title: const Text('Edit Community'),
            onTap: (){
              navigateToEditScreen(context);
          

            },
          ),

        ],
      ) ,
    );
  }
}
