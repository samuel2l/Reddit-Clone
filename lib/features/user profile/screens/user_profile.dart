import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/features/auth/controller/auth_controller.dart';

class ProfileScreen extends ConsumerWidget {
  final String uId;
  const ProfileScreen({super.key,required this.uId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user=ref.watch(userProvider);
    
    return SafeArea(child: 
    Scaffold(
      body: ref.watch(getUserDataProvider(uId)).when(data: (user){
        return NestedScrollView(headerSliverBuilder: (context,innerBarIsScrolled){
          return [
            SliverAppBar(
              floating: true,
              snap:true,
              expandedHeight: 250,
              flexibleSpace: Stack(
                children: [
                  Positioned.fill(child: Image.network(user!.dp,
                  fit: BoxFit.cover,
                  ),
                  ),

Container(
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.all(20).copyWith(left: 70),
child: CircleAvatar(
                                backgroundImage: NetworkImage(user.dp),
                                radius: 45,
                              ),
),
                          
                  Container(
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.all(20),
                    child: OutlinedButton(
                                          onPressed: () {                                          
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            padding: const EdgeInsets.symmetric(horizontal: 25),
                                          ),
                                          child: const Text('Edit Profile'),
                                        ),
                  ),

                ],
              ),
            ),
            SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'u/${user.name}',
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                                      Padding(padding: const EdgeInsets.only(top:10),
                                      child: Text('${user.karma} '),
                                        ),
                                        const SizedBox(height: 10,),
                                        const Divider(thickness: 2,),
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