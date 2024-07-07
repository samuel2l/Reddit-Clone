import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class CommunityList extends ConsumerWidget {
  const CommunityList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(child: Column(
        children: [
          ListTile(
            title:const Text('Create Community'),
            leading:const  Icon(Icons.add),
            onTap: (){
              Routemaster.of(context).push('/create-community');
            },
          )
        ],
      )),
    );
  }
}