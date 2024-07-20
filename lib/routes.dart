//so we will create 2 main routes for when a user is logged in or not showing the pages that can be accessed by such a user
//the ease with which we can do this using route master is why it was chosen
import 'package:flutter/material.dart';
import 'package:reddit/features/community/screens/add_mods.dart';
import 'package:reddit/features/community/screens/community_screen.dart';
import 'package:reddit/features/community/screens/create_community.dart';
import 'package:reddit/features/community/screens/edit_community.dart';
import 'package:reddit/features/community/screens/mod_tools.dart';
import 'package:reddit/features/home/screens/home.dart';
import 'package:reddit/features/auth/screens/login.dart';
import 'package:reddit/features/user%20profile/screens/user_profile.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoutes = RouteMap(routes: {
  '/':(_)=>const MaterialPage(child:LoginScreen()),
  
});

//so you can have same route paths for different paths 
//eg the home route,/, when logged out shows login screen 
//but shows home screen when logged in
final loggedInRoutes = RouteMap(routes: {
  '/':(_)=>const MaterialPage(child:HomeScreen()),
    '/create-community':(_)=>const MaterialPage(child:CreateCommunity()),
    //we will need to use dynamic routes to search for communities
    '/r/:name':(route)=> MaterialPage(child:CommunityScreen(
      name: route.pathParameters['name']!,
    )),
    '/mod-tools/:name':(routeData)=> MaterialPage(child:ModTools(name: routeData.pathParameters['name']!,),
    ),
    '/edit-community/:name':(routeData)=> MaterialPage(child:EditCommunity(name: routeData.pathParameters['name']!,),
    ),
    '/add-mods/:name':(routeData)=> MaterialPage(child:AddMods(name: routeData.pathParameters['name']!,),
    ),
     '/u/:uId':(routeData)=> MaterialPage(child:ProfileScreen(uId: routeData.pathParameters['uId']!,),
    ),
    '/edit-profile/:uId':(routeData)=> MaterialPage(child:AddMods(name: routeData.pathParameters['uId']!,),
    ),
});
