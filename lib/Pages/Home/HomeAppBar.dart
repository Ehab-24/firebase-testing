

import 'package:firebase_testing/Globals/decorations.dart';
import 'package:firebase_testing/Globals/providers.dart';
import 'package:firebase_testing/Globals/shapes.dart';
import 'package:firebase_testing/Globals/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  
  final TabController controller;
  
  const HomeAppBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(120);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar>
  with SingleTickerProviderStateMixin {
  
  @override
  Widget build(BuildContext context) {

    final double w = MediaQuery.of(context).size.width;

    return AppBar(
      
      shape: Shapes.appBar(w),

      shadowColor: Colors.white,

      elevation: 5,

      bottom: const Header(),
  
      title: MainTabBar(controller: widget.controller),

      centerTitle: true,
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {

    final double w = MediaQuery.of(context).size.width;

    return Container(
  
      width: w * 0.45,
      height: 50,
      alignment: Alignment.center,
      
      decoration: Decorations.appBarHeader,
      child: const Text(
        'Firebase',
        style: TextStyles.appBarHeader
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class MainTabBar extends StatefulWidget {

  final TabController controller;

  const MainTabBar({
    Key? key, required this.controller,
  }) : super(key: key);

  @override
  State<MainTabBar> createState() => _MainTabBarState();
}

class _MainTabBarState extends State<MainTabBar> {
  @override
  Widget build(BuildContext context) {

    int currentPage = Provider.of<Page_pr>(context).currentPageIndex;

    return TabBar(
        
      controller: widget.controller,
  
      onTap: ((value) {
        Provider.of<Page_pr>(context, listen: false).setPage(value);
      }),
        
      indicatorWeight: 8,
      indicatorColor: Colors.grey.shade900,
        
      tabs: [
        _tab(currentPage == 0? const Icon(Icons.home, color: Color.fromRGBO(33, 33, 33, 1), size: 36): const Icon(Icons.home_outlined, color: Color.fromRGBO(33, 33, 33, 1), size: 28)),
        _tab(currentPage == 1? const Icon(Icons.book, color: Color.fromRGBO(33, 33, 33, 1), size: 36): const Icon(Icons.book_outlined, color: Color.fromRGBO(33, 33, 33, 1), size: 28)),
        _tab(currentPage == 2? const Icon(Icons.person, color: Color.fromRGBO(33, 33, 33, 1), size: 36): const Icon(Icons.person_outlined, color: Color.fromRGBO(33, 33, 33, 1), size: 28)),
      ],
    );
  }

  Tab _tab(Icon icon) =>
    Tab(
      icon: icon,
    );
}
