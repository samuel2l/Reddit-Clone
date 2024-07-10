import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/features/community/controller/community_controller.dart';

class CommunityScreen extends ConsumerWidget {
  final String name;
  const CommunityScreen( {required this.name,super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(child: 
    Scaffold(
      body: ref.watch(getCommunityProvider(name)).when(data: (data){
        return NestedScrollView(headerSliverBuilder: (context,innerBarIsScrolled){
          return [
            SliverAppBar(
              floating: true,
              snap:true,
              expandedHeight: 150,
              flexibleSpace: Stack(
                children: [
                  Positioned.fill(child: Image.network(data.banner,fit: BoxFit.cover,),),
                ],
              ),
            )


          ];
        }, body: Container());
      }, error: (error,stackTrace)=>Center(child:Text(error.toString())), loading: ()=>const CircularProgressIndicator()),
    ));
  }
}