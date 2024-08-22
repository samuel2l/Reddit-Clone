import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/features/auth/controller/auth_controller.dart';
import 'package:reddit/features/home/delegates/search_community_delegates.dart';
import 'package:reddit/features/home/drawers/community_list.dart';
import 'package:reddit/features/home/drawers/user_profile_drawer.dart';
import 'package:reddit/themes/pallette.dart';



class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  int _page=0;
void displayDrawer(BuildContext context) {
  Scaffold.of(context).openDrawer();
}
void displayEndDrawer(BuildContext context) {
  Scaffold.of(context).openEndDrawer();
}

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }
  @override
  Widget build(BuildContext context) {
        final user = ref.watch(userProvider)!;
    final currTheme=ref.watch(themeNotifierProvider);

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
            //wrapped with another builder cos there wa sinitial error of the 
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
      bottomNavigationBar: CupertinoTabBar(items:const [
        BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: '',
                ),
      ],
      activeColor: currTheme.iconTheme.color,
      backgroundColor: currTheme.colorScheme.background,
      onTap: onPageChanged,
      ),
      );
  }
}