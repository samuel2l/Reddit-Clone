import 'package:flutter/material.dart';

class ModTools extends StatelessWidget {
  const ModTools({super.key});

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
            onTap: (){},
          )
        ],
      ) ,
    );
  }
}