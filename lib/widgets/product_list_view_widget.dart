/*
 * Copyright (C) 2019 Baidu, Inc. All Rights Reserved.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Sliver 商品列表
class SliverProductList extends StatelessWidget {

  final List list;

  SliverProductList({Key key,this.list}):super(key : key);

  /// 商品列表 双列构造
  List<Widget> _getListVidget(){
    return list.map((obj){
      return  InkWell(
        onTap: () {},
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(bottom: 3),
          child: Column(
            children: <Widget>[
              Image.network(obj['pictUrl'], width: ScreenUtil().setWidth(370)),
              Text(
                obj['title'],
                style: TextStyle(
                    color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: <Widget>[
                  Text("￥255"),
                  Text(
                    "￥255",
                    style: TextStyle(color: Colors.black12),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }).toList();
  }
  Widget _List() {
    if (list.length != 0) {
      return SliverGrid.count(
          crossAxisCount: 2, //横轴数量
          crossAxisSpacing: 1.0,//横轴间距
          mainAxisSpacing: 1.0,//纵轴间距
          childAspectRatio: 0.75,//横纵比例 长宽只能这个属性设置
          children: _getListVidget(),
      );
    } else {
      return SliverToBoxAdapter(
        child: Text("正在加载"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _List(),
    );
  }
}

/// Sliver 商品列表
class ProductList extends StatelessWidget {

  final List list;

  ProductList({Key key,this.list}):super(key : key);

  /// 商品列表 双列构造
  List<Widget> _getListVidget(){
    return list.map((obj){
      return  InkWell(
        onTap: () {},
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(bottom: 3),
          child: Column(
            children: <Widget>[
              Image.network(obj['pictUrl'], width: ScreenUtil().setWidth(370)),
              Text(
                obj['title'],
                style: TextStyle(
                    color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: <Widget>[
                  Text("￥255"),
                  Text(
                    "￥255",
                    style: TextStyle(color: Colors.black12),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }).toList();
  }


  Widget _List() {
    if (list.length != 0) {
      return GridView.count(
        shrinkWrap:true,
        physics: new NeverScrollableScrollPhysics(),
        crossAxisCount: 2, //横轴数量
        crossAxisSpacing: 1.0,//横轴间距
        mainAxisSpacing: 1.0,//纵轴间距
        childAspectRatio: 0.75,//横纵比例 长宽只能这个属性设置
        children: _getListVidget(),
      );
    } else {
      return Text("正在加载");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _List(),
    );
  }
}

