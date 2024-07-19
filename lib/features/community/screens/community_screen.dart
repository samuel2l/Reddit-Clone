import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/features/auth/controller/auth_controller.dart';
import 'package:reddit/features/community/controller/community_controller.dart';
import 'package:reddit/features/models/community_model.dart';
import 'package:routemaster/routemaster.dart';


class CommunityScreen extends ConsumerWidget {
  final String name;
  const CommunityScreen( {required this.name,super.key});
void navigateToModTools(BuildContext context){
  Routemaster.of(context).push('/mod-tools/$name');
}
void joinComunity(WidgetRef ref,Community community,BuildContext context){
  ref.read(communityControllerProvider.notifier).joinCommunity(community, context);
}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return SafeArea(child: 
    Scaffold(
      body: ref.watch(getCommunityProvider(name)).when(data: (community){
        return NestedScrollView(headerSliverBuilder: (context,innerBarIsScrolled){
          return [
            SliverAppBar(
              floating: true,
              snap:true,
              expandedHeight: 150,
              flexibleSpace: Stack(
                children: [
                  Positioned.fill(child: Image.network(community.banner,fit: BoxFit.cover,),),
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
                              backgroundImage: NetworkImage(community.dp),
                              radius: 35,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'r/${community.name}',
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              community.mods.contains(user.uId)?
OutlinedButton(
                                        onPressed: () {
                                          navigateToModTools(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal: 25),
                                        ),
                                        child: const Text('Mod Tools'),
                                      ):OutlinedButton(
                                        onPressed: () {
                                          community.members.contains(user.uId)?
                                          //not sure if just nulling it will work
                                          //logic here is me just ensuring that do nothing when button is taped if user is already inside the community 
                                         null :joinComunity(ref, community, context);

                                          
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal: 25),
                                        ),
                                        child: Text(community.members.contains(user.uId)?'Joined':'Join'),
                                      ),
                                      Padding(padding: const EdgeInsets.only(top:10),
                                      child: Text('${community.members.length} members '),
                                        )
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