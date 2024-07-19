import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/features/community/controller/community_controller.dart';
import 'package:routemaster/routemaster.dart';

class SearchCommunityDelegate extends SearchDelegate{
  final WidgetRef ref;
  SearchCommunityDelegate(this.ref);

  @override
  List<Widget>? buildActions(BuildContext context) {
   return [
    IconButton(onPressed: (){
      query='';
    }, icon: const Icon(Icons.close))

   ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
 return null;
  }

  @override
  Widget buildResults(BuildContext context) {
return const SizedBox();  }

  @override
  Widget buildSuggestions(BuildContext context) {
return ref.watch(searchCommunityProvider(query)).when(
          data: (communites) => ListView.builder(
            itemCount: communites.length,
            itemBuilder: (BuildContext context, int index) {
              final community = communites[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(community.dp),
                ),
                title: Text('r/${community.name}'),
                onTap: () => navigateToCommunity(context, community.name),
              );
            },
          ),
          error: (error, stackTrace) => 
           Text(error.toString()),
          
          loading: () =>const Center(child: CircularProgressIndicator(),),
        );
  }

  void navigateToCommunity(BuildContext context, String communityName) {
    Routemaster.of(context).push('/r/$communityName');
  }
}
 