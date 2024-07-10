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
            ),
            SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Align(
                            alignment: Alignment.topLeft,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(data.dp),
                              radius: 35,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'r/${data.name}',
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
OutlinedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal: 25),
                                        ),
                                        child: Text('Join'),
                                      ),
                          ],
                          ),
                          
                          ],
                          ),
                          ),)


          ];
        }, body: Container());
      }, error: (error,stackTrace)=>Center(child:Text(error.toString())), loading: ()=>const CircularProgressIndicator()),
    ));
  }
}