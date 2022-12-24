
import 'package:firebase_testing/Pages/Content/ContentPage.dart';
import 'package:firebase_testing/Pages/Home/HomeAppBar.dart';
import 'package:firebase_testing/Pages/Home/HomePage.dart';
import 'package:firebase_testing/Pages/Profile/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Globals/providers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin<HomeScreen>{
  
  late final TabController controller;

  @override
  void initState() {
    controller = TabController(length: 3, initialIndex: 0, vsync: this);
    controller.addListener(() {
      Provider.of<Page_pr>(context, listen: false).setPage(controller.index);
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
      backgroundColor: Colors.grey.shade900,
    
      appBar: HomeAppBar(controller: controller),
  
      body: TabBarView(
        controller: controller,
        children: const [
          HomeBody(),
          ContentPage(),
          ProfilePage()
        ],
      )
    );
  }
}


