import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/features/community/controller/community_controller.dart';
import 'package:reddit/features/models/community_model.dart';
import 'package:routemaster/routemaster.dart';

class CommunityList extends ConsumerWidget {
  const CommunityList({super.key});
void NavigateToCreateCommunity(BuildContext context){
  Routemaster.of(context).push('/create-community');
}
void NavigateToCommunity(BuildContext context, Community community){
  Routemaster.of(context).push('/r/${community.name}');
}
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(child: Column(
        children: [
          ListTile(
            title:const Text('Create Community'),
            leading:const  Icon(Icons.add),
            onTap:(){
              NavigateToCreateCommunity(context);
            } ,

          ),
          ref.watch(userCommunitiesProvider).when(data:(data)=> Expanded(
            child: ListView.builder(itemCount: data.length,itemBuilder: (context, index) {
              print('list item ${data[index]}');
              return ListTile(
                title: Text('r/${data[index].name}'),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(data[index].dp),
              ),
              onTap: (){
                NavigateToCommunity(context,data[index]);
              },
              );
            }, ),
          ), error:(error,stackTrace){
            return Center(
              child: Text(error.toString()),
            );
          }, loading: ()=>const CircularProgressIndicator())
        ],
      )),
    );
  }
}