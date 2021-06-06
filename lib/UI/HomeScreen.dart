import 'package:GridPost2/UI/PostView.dart';
import 'package:GridPost2/UI/grid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index1 = 0;
  PageController _controller = new PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [
          Grid(),
          PostView()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            index1 = index;
            _controller.animateToPage(index, duration: Duration(milliseconds: 400), curve: Curves.easeIn);
          });
        },
        currentIndex: index1,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(CupertinoIcons.circle_grid_3x3_fill,color: Colors.red,),
            icon: Icon(CupertinoIcons.circle_grid_3x3_fill),
            label: 'Home',
          ),
          BottomNavigationBarItem(
          activeIcon: Icon(CupertinoIcons.collections_solid,color: Colors.red),
            icon: Icon(CupertinoIcons.collections_solid),
            label: 'News',
          ),
        ],
      ),
    );
  }
}

