/*
 * Copyright (C) 2019 Baidu, Inc. All Rights Reserved.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:tbk_app/util/screen_utils.dart';

class HomePageOne extends StatefulWidget {
  @override
  _HomePageOneState createState() => _HomePageOneState();
}

class _HomePageOneState extends State<HomePageOne> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        /// 轮播图片
        SwiperWidget(),

//        /// 横线
        Divider(
          color: Colors.white,
          height: 1,
        ),

        /// 活动图
        GestureDetector(
          child: Image.network(
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1559819963126&di=666aae9a776dbc44af68c7743beb9876&imgtype=0&src=http%3A%2F%2Fphotocdn.sohu.com%2F20160301%2Fmp61159151_1456789746291_8.gif",
            width: ScreenUtils.screenW(context),
          ),
          onTap: () {
            print("onTap");
          },
        ),
        WrapWidget(),
        /// 轮播图片
        SwiperWidget(),
//        Text("eeeee"),
        WrapWidget(),
        ///
      ],
    );
  }
}

/// SwiperWidget  start

class SwiperWidget extends StatefulWidget {
  @override
  _SwiperWidgetState createState() => _SwiperWidgetState();
}

class _SwiperWidgetState extends State<SwiperWidget> {
  // 声明一个list，存放image Widget
  List<Widget> imageList = List();

  @override
  void initState() {
    imageList
      ..add(Image.network(
        'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2726034926,4129010873&fm=26&gp=0.jpg',
        fit: BoxFit.fill,
      ))
      ..add(Image.network(
        'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3485348007,2192172119&fm=26&gp=0.jpg',
        fit: BoxFit.fill,
      ))
      ..add(Image.network(
        'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2594792439,969125047&fm=26&gp=0.jpg',
        fit: BoxFit.fill,
      ))
      ..add(Image.network(
        'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=190488632,3936347730&fm=26&gp=0.jpg',
        fit: BoxFit.fill,
      ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
      width: MediaQuery.of(context).size.width,
      height: 150,
//      color: Colors.pink.shade400,
      decoration: BoxDecoration(
        color: Colors.pink.shade800,
//        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Swiper(
        itemCount: this.imageList.length,
        itemBuilder: (context, index) => this.imageList[index],
        pagination: SwiperPagination(
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          builder: DotSwiperPaginationBuilder(
            color: Colors.white,
            activeColor: Colors.redAccent,
            activeSize: 9,
            size: 9,
            space: 8,
          ),
        ),
        controller: SwiperController(),
        scrollDirection: Axis.horizontal,
        autoplay: true,
//        viewportFraction: 0.8,
        scale: 0.9,
        onTap: (index) => print('点击了第$index'),
      ),
    );
  }
}

/// SwiperWidget  end

class FlowWidget extends StatefulWidget {
  @override
  _FlowWidgetState createState() => _FlowWidgetState();
}

class _FlowWidgetState extends State<FlowWidget> {
  static const width = 80.0;
  static const height = 60.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Flow(
        delegate: TestFlowDelegate(
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0)),
        children: <Widget>[
          new Container(
            width: width,
            height: height,
            color: Colors.yellow,
          ),
          new Container(
            width: width,
            height: height,
            color: Colors.green,
          ),
          new Container(
            width: width,
            height: height,
            color: Colors.red,
          ),
          new Container(
            width: width,
            height: height,
            color: Colors.black,
          ),
          new Container(
            width: width,
            height: height,
            color: Colors.blue,
          ),
          new Container(
            width: width,
            height: height,
            color: Colors.lightGreenAccent,
          ),
        ],
      ),
    );
  }
}

class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;

  TestFlowDelegate({this.margin});

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}

class WrapWidget extends StatefulWidget {
  @override
  _WrapWidgetState createState() => _WrapWidgetState();
}

class _WrapWidgetState extends State<WrapWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.fromLTRB(0,0,0,0),
        padding: EdgeInsets.all(1),
        color: Colors.redAccent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(4),
          child: Wrap(
            spacing: 20.0, // gap between adjacent chips
            runSpacing: 20.0, // gap between lines
            alignment: WrapAlignment.center,
            children: <Widget>[
              Column(

                children: <Widget>[
                  Image.network("http://cdn.duitang"
                      ".com/uploads/item/201610/03/20161003000301_Wfm5X.jpeg",
                    width: MediaQuery.of(context).size.width/5,
                  ),
                  Text("wwwww"),
                ],
              ),Column(

                children: <Widget>[
                  Image.network("http://cdn.duitang"
                      ".com/uploads/item/201610/03/20161003000301_Wfm5X.jpeg",
                    width: MediaQuery.of(context).size.width/5,
                  ),
                  Text("wwwww"),
                ],
              ),Column(

                children: <Widget>[
                  Image.network("http://cdn.duitang"
                      ".com/uploads/item/201610/03/20161003000301_Wfm5X.jpeg",
                    width: MediaQuery.of(context).size.width/5,
                  ),
                  Text("wwwww"),
                ],
              ),Column(

                children: <Widget>[
                  Image.network("http://cdn.duitang"
                      ".com/uploads/item/201610/03/20161003000301_Wfm5X.jpeg",
                    width: MediaQuery.of(context).size.width/5,
                  ),
                  Text("wwwww"),
                ],
              ),Column(

                children: <Widget>[
                  Image.network("http://cdn.duitang"
                      ".com/uploads/item/201610/03/20161003000301_Wfm5X.jpeg",
                    width: MediaQuery.of(context).size.width/5,
                  ),
                  Text("wwwww"),
                ],
              ),Column(

                children: <Widget>[
                  Image.network("http://cdn.duitang"
                      ".com/uploads/item/201610/03/20161003000301_Wfm5X.jpeg",
                    width: MediaQuery.of(context).size.width/5,
                  ),
                  Text("wwwww"),
                ],
              ),Column(

                children: <Widget>[
                  Image.network("http://cdn.duitang"
                      ".com/uploads/item/201610/03/20161003000301_Wfm5X.jpeg",
                    width: MediaQuery.of(context).size.width/5,
                  ),
                  Text("wwwww"),
                ],
              ),Column(

                children: <Widget>[
                  Image.network("http://cdn.duitang"
                      ".com/uploads/item/201610/03/20161003000301_Wfm5X.jpeg",
                    width: MediaQuery.of(context).size.width/5,
                  ),
                  Text("wwwww"),
                ],
              ),
            ],
          ),
        )
    );
  }
}
