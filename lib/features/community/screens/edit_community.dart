import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/features/community/controller/community_controller.dart';
import 'package:reddit/features/models/community_model.dart';
import 'package:reddit/themes/pallette.dart';
import 'package:reddit/utils.dart';

class EditCommunity extends ConsumerStatefulWidget {
  final String name;
  const EditCommunity( {super.key,required this.name});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditCommunityState();
}

class _EditCommunityState extends ConsumerState<EditCommunity> {
  
File? bannerImg;
File? dp;

void pickBanner()async{
  final res= await pickImage();
  if(res!=null){
    setState(() {
      bannerImg=File(res.files.first.path!);
    });
  }

}
void pickDp()async{
  final res= await pickImage();
  if(res!=null){
    setState(() {
      dp=File(res.files.first.path!);
    });
  }

}
void save(WidgetRef ref,Community community,BuildContext context){
  ref.read(communityControllerProvider.notifier).editCommunity(community: community, banner: bannerImg, dp: dp, context: context);

}
  @override
  Widget build(BuildContext context) {
    
    return ref.watch(getCommunityProvider(widget.name)).when(data: (data){
      return SafeArea(child: Scaffold(
      backgroundColor: Pallete.darkModeAppTheme.dialogBackgroundColor,
      appBar: AppBar(
        title: const Text('Edit Community'),
        centerTitle: false,
        actions: [
          TextButton(onPressed:()=> save(ref,data,context), child: const Text('Save')),
        ],
      ),
      body:  Padding(
        padding: const EdgeInsets.only(left:6,right:6,top:6),
        child: SizedBox(
          //give stack height to position the dp better
          
          height:200,
          child: Stack(
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: pickBanner,
                    child: DottedBorder(borderType: BorderType.RRect,radius: const Radius.circular(10),dashPattern:const [10,4],
                    strokeCap: StrokeCap.round,
                    color: Colors.white,
                                  
                    child: Container(
                      
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7)
                      ),
                      child:bannerImg!=null?Image.file(bannerImg!,fit:BoxFit.cover,): data.banner.isEmpty || data.banner==bannerDefault? const Center(child: Icon(Icons.camera_alt_outlined,size: 40,),) : Image.network(data.banner),
                    ),
                    ),
                  ),
                ],
              ),
Positioned(
  left: 20,
  bottom: 20,
  child: GestureDetector(
    onTap: pickDp,
    child: dp!=null?CircleAvatar(
      backgroundImage: FileImage(dp!),

radius: 32,
    ):CircleAvatar(
      backgroundImage: NetworkImage(data.dp),

radius: 32,
    )
  ),
)
            ],
          ),
        ),
      ),
    ));

    }, error: (error,stackTrace)=>Text(error.toString()), loading: ()=>const Center(child:CircularProgressIndicator()),
    );
       }
}