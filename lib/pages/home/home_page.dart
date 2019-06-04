/*
 * Copyright (C) 2019 Baidu, Inc. All Rights Reserved.
 */
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tbk_app/widgets/search_text_field_widget.dart';
import 'dart:math' as math;

import 'package:tbk_app/widgets/tab_bar_view_widget.dart';

import '../../router.dart';

var titleList = ['电影', '电视', '综艺', '读书', '音乐', '22', '33', '44', '55', '66'];

List<Widget> tabList;

TabController _tabController;

/// 首页
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _BookAudioVideoPageState();
  }
}

/// 首页 state
class _BookAudioVideoPageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var tabBar;

  var hintText = "替换这里的文字";

  @override
  void initState() {
    super.initState();
    tabBar = new HomePageTabBar();
    tabList = this.getTabList();
    _tabController = TabController(vsync: this, length: tabList.length);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new SafeArea(
        child: new DefaultTabController(
          length: titleList.length,
          child: new NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  new SliverToBoxAdapter(
                    child: new Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(10.0),
                      child: SearchTextFieldWidget(
                        hintText: hintText,
                        onTab: () {
                          Router.push(context, Router.searchPage, hintText);
                        },
                      ),
                    ),
                  ),
                  new SliverPersistentHeader(
                    floating: true,
                    pinned: true,
                    delegate: new _SliverAppBarDelegate(
                      maxHeight: 49.0,
                      minHeight: 49.0,
                      child: new Container(
                        color: Colors.white,
                        child: tabBar,
                      ),
                    ),
                  )
                ];
              },
              body: FlutterTabBarView(
                tabController: _tabController,
              )),
        ),
      ),
    );
  }

  List<Widget> getTabList() {
    return titleList
        .map((item) => Text(
              '$item',
              style: TextStyle(fontSize: 15),
            ))
        .toList();
  }
}

/// 头部导航栏
class HomePageTabBar extends StatefulWidget {
  HomePageTabBar({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _HomePageTabBarState();
  }
}

/// 头部导航栏 state
class _HomePageTabBarState extends State<HomePageTabBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: TabBar(
        tabs: tabList,
        isScrollable: true,
        controller: _tabController,
        indicatorColor: Colors.pinkAccent,
        labelColor: Colors.pinkAccent,
        labelStyle: TextStyle(fontSize: 18, color: Colors.black),
        unselectedLabelColor: Color.fromARGB(255, 117, 117, 117),
        unselectedLabelStyle: TextStyle(fontSize: 18, color: Colors.black),
        indicatorSize: TabBarIndicatorSize.label,
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max((minHeight ?? kToolbarHeight), minExtent);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
