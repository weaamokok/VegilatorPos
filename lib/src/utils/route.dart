import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../landing/presentaion/main_screen.dart';

class AppRoute{
  static final router = GoRouter(
   routes: <RouteBase>[
     GoRoute(
       path: "/",
       builder: ( context,  state){
        return  MainPage();
       },
       routes: [
         GoRoute(
           path: "details",
           builder: (_, __) => Scaffold(
             appBar: AppBar(title: const Text('Details Screen')),
           ),
         ),
       ],
     ),
   ],
 );
}