import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/features/auth/controller/auth_controller.dart';
import 'package:reddit/features/home/delegates/search_community_delegates.dart';
import 'package:reddit/features/home/drawers/community_list.dart';
import 'package:reddit/features/home/drawers/user_profile.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
void displayDrawer(BuildContext context) {
  Scaffold.of(context).openDrawer();
}
void displayEndDrawer(BuildContext context) {
  Scaffold.of(context).openEndDrawer();
}
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) 
          {
            // we wrap with builder cos when calling display drawer we need to pass in a different context than the one the current widget tree has
            // #same can be done by just extracting the icon button into its own widget with its own scaffold
            return IconButton(icon: const Icon(Icons.menu),onPressed: ()=>displayDrawer(context),);
          }
        ),
        title: const Text('Home'),
        centerTitle: false,
        actions: [

          IconButton(onPressed: (){
showSearch(context: context, delegate: SearchCommunityDelegate(ref));
          }, icon:const Icon(Icons.search,)),
          Builder(
            builder: (context) {
              return IconButton(icon: CircleAvatar(backgroundImage: NetworkImage(user.dp),),onPressed:()=>
                displayEndDrawer(context)
              ,);
            }
          ),
          
        ],
        

      ),
      drawer: const CommunityList(),
      endDrawer: const ProfileDrawer(),
      );
    
  }
}
