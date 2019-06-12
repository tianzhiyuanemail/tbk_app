import 'package:flutter/material.dart';
import 'package:tbk_app/pages/home/hom_page_other.dart';
import 'package:tbk_app/pages/home/home_page_first.dart';

class FlutterTabBarView extends StatelessWidget {
  final TabController tabController;

  FlutterTabBarView({Key key, @required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewList = [
      HomePageFirst(),
      HomePageOther(),
      Page2(),
      Page2(),
      Page2(),
      Page2(),
      Page2(),
      Page4(),
      Page5(),
      Page1(),
    ];
    return TabBarView(

      children: viewList,
      controller: tabController,
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build Page1');

    return Center(
      child: Text('Page1'),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build Page2');
    return Center(
      child: Text('Page2'),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build Page3');
    return Center(
      child: Text('Page3'),
    );
  }
}

class Page4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build Page4');
    return Center(
      child: Text('Page4'),
    );
  }
}

class Page5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build Page5');
    return Center(
      child: Text('Page5'),
    );
  }
}
