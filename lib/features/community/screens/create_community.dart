import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateCommunity extends ConsumerStatefulWidget {
  const CreateCommunity({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateCommunityState();
}

class _CreateCommunityState extends ConsumerState<CreateCommunity> {
  final communityNameController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: 
    Scaffold(appBar: AppBar(title:const Text('Create Community'),
   
    ),
    body:
     Padding(
      padding:const EdgeInsets.all(8.0),
      child:  Column(
       
        children: [
          const Text('Enter community name'),
          TextField(
            controller: communityNameController,
            decoration: const InputDecoration(
              hintText: 'Enter community name',
            filled: true,
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(8)
            ),
            maxLength: 21,

          ),
          const SizedBox(height:20),
          TextButton(onPressed: (){}, child: const Text(''))
          
                  ],
      ),
    ),
    ),
    );
  }
}