// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/features/auth/controller/auth_controller.dart';
import 'package:reddit/features/community/controller/community_controller.dart';

class AddMods extends ConsumerStatefulWidget {
final String name;
  const AddMods({super.key, 
    required this.name,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddModsState();
}
class _AddModsState extends ConsumerState<AddMods> {
  Set<String> uIds={};
  //add a counter so you can select and deselect already existing mods
  //logic is so when build func re runs when you call set state the users id is not added to uids set unless the count is at 0
  //without this when you try to remove a mod the removemod fucntion calls setstate causing the whole tree to be rebuilt and this line of code:
  //if(community.mods.contains(community.members[index]))
  // reruns hence adding the user you want to the uIds set again hence the reason why a mod cannot be deselected
  int count=0;
  void addUid(String uId){
    setState(() {
      uIds.add(uId);
    });
  }
  void removUid(String uId){
    setState(() {
      uIds.remove(uId);
    });
  }
  void saveModChanges(){
    ref.read(communityControllerProvider.notifier).addMods(widget.name, uIds.toList(), context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
              saveModChanges();

            },
           icon:const Icon(Icons.done)
),
        ],
      ),
      body: ref.watch(getCommunityProvider(widget.name)).when(data: (community){
return ListView.builder(
  itemCount: community.members.length,
  itemBuilder: (context, index){
    // community.members[index] returns the users uId
    // so to get the members name we will use the getUserData provider which takes a uId as a param
    //since we are using another provider we will have another .when nested you barb
    return ref.watch(getUserDataProvider(community.members[index])).when(data:(user){
    if(community.mods.contains(community.members[index]) && count==0){
      uIds.add(community.members[index]);
    }

  count++;
    return CheckboxListTile(

value: uIds.contains(user!.uId),
//if the value property is true then it means the list tile will be checked
onChanged: (value) {
  if(value!){
addUid(user.uId);
  }else{
    removUid(user.uId);
  }
  
},
      title: Text(user.name),

    );

    } ,error:(error,stackTrace)=> Text(error.toString()), loading:()=> const Center(child:CircularProgressIndicator(),
      ), );

  },);
      }, error:(error,stackTrace)=> Text(error.toString()), loading:()=> const Center(child:CircularProgressIndicator(),
      ),
      ),
      ),
    );
  }
}