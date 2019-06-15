/*
 * Copyright (C) 2019 Baidu, Inc. All Rights Reserved.
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CatePage extends StatefulWidget {
  @override
  _CatePageState createState() => _CatePageState();
}

class _CatePageState extends State<CatePage>  with SingleTickerProviderStateMixin {
  Animation<double> numberAnimation;
  AnimationController controller;
  double selectIndex = 0;
  List list = new List(50);
  ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController(initialScrollOffset: 0,keepScrollOffset: false);
    controller = new AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _changeSelected(selectIndex,0);
  }
  @override
  dispose() {
    controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          leftWidget(),
          rightWidget(),
        ],
      ),
    );
  }
  ///   ----------------------------------------------------------------------------------


  /// 切换选择
  _changeSelected(double begin,double end ) {
    final CurvedAnimation curve = new CurvedAnimation(parent: controller, curve: Curves.elasticOut);
    numberAnimation = new Tween(begin: begin, end: end)
        .animate(controller)
      ..addListener((){
        setState(() {
          selectIndex =  numberAnimation.value;
        });
      });
    controller.forward(from: 0.0);
  }
  /// 滚动到选择的位置
  _animateTo(double index){

    double scrollNumber = (index-1) * ScreenUtil().height/50;
//    if(scrollNumber >ScreenUtil().height/2){
//      scrollNumber = scrollNumber*5/4;
//    }else if(scrollNumber <ScreenUtil().height/2){
//      scrollNumber = scrollNumber*3/4;
//    }
    _scrollController.animateTo(scrollNumber, duration: new Duration(milliseconds: 300), curve: Curves.ease);
  }

  Widget _item(double index) {
    bool _selected = selectIndex.toInt() == index.toInt();

    return InkWell(
      onTap: (){
        _changeSelected(selectIndex ,index );
        _animateTo(index);
      },
      child: Container(
        margin: EdgeInsets.only(top: 10,bottom: 10,left: 5,right: 5),
        padding: EdgeInsets.only(top: 3,bottom: 3),
        height: ScreenUtil().setWidth(50),
        decoration: _selected
            ? BoxDecoration(
          color: Colors.redAccent,
          border: Border.all(width: 2.0, color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        )
            : BoxDecoration(
          border: Border.all(width: 2.0,color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Text(
          ""+index.toString(),
          style: TextStyle(
            color: _selected ? Colors.white : Colors.black,
            letterSpacing: 6,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
        ),
      ),
    );
  }

  Widget leftWidget() {
    return Container(
      width: 80,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 2, color: Colors.white),
          )),
      child: ListView(
        controller: _scrollController,
        children: list.asMap().keys.map((v) {
          return _item(v.toDouble());
        }).toList(),
      ),
    );
  }

  Widget rightWidget() {
    return Container(
      color: Colors.amberAccent,
      width: 280,
    );
  }
}

