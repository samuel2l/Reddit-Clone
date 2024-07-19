// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){},
           icon:const Icon(Icons.save)
),
        ],
      ),
      body: ref.watch(getCommunityProvider(widget.name)).when(data: (community){
return ListView.builder(
  itemCount: community.members.length,
  itemBuilder: (context, index){
    return ListTile(
      leading: const Icon(Icons.person),
      title: Text(community.members[index]),

    );
  },);
      }, error:(error,stackTrace)=> Text(error.toString()), loading:()=> const Center(child:CircularProgressIndicator(),
      ),
      ),
      ),
    );
  }
}