import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/features/community/controller/community_controller.dart';
import 'package:reddit/themes/pallette.dart';

class EditCommunity extends ConsumerStatefulWidget {
  final String name;
  const EditCommunity( {super.key,required this.name});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditCommunityState();
}

class _EditCommunityState extends ConsumerState<EditCommunity> {

  @override
  Widget build(BuildContext context) {
    return ref.watch(getCommunityProvider(widget.name)).when(data: (data){
      return SafeArea(child: Scaffold(
      backgroundColor: Pallete.darkModeAppTheme.dialogBackgroundColor,
      appBar: AppBar(
        title: const Text('Edit Community'),
        centerTitle: false,
        actions: [
          TextButton(onPressed: (){}, child: const Text('Save')),
        ],
      ),
      body:  Padding(
        padding: const EdgeInsets.only(left:6,right:6,top:6),
        child: Column(
          children: [
            DottedBorder(radius: const Radius.circular(10),dashPattern:const [10,4],
            strokeCap: StrokeCap.round,
            color: Colors.white,

            child: Container(
              
              height: 130,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7)
              ),
              child: data.banner.isEmpty || data.banner==bannerDefault? const Center(child: Icon(Icons.camera_alt_outlined,size: 40,),) : Image.network(data.banner),
            ),
            ),
          ],
        ),
      ),
    ));

    }, error: (error,stackTrace)=>Text(error.toString()), loading: ()=>Center(child:CircularProgressIndicator()),
    );
       }
}