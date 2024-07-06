//so we will create 2 main routes for when a user is logged in or not showing the pages that can be accessed by such a user
//the ease with which we can do this using route master is why it was chosen
import 'package:flutter/material.dart';
import 'package:reddit/screens/home.dart';
import 'package:reddit/screens/login.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoutes = RouteMap(routes: {
  '/':(_)=>const MaterialPage(child:LoginScreen()),
  
});

//so you can have same route paths for different paths 
//eg the home route,/, when logged out shows login screen 
//but shows home screen when logged in
final loggedInRoutes = RouteMap(routes: {
  '/':(_)=>const MaterialPage(child:HomeScreen()),
  
});
