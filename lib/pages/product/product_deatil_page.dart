/*
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:tbk_app/config/service_method.dart';
import 'package:tbk_app/modle/product_model.dart';
import 'package:tbk_app/widgets/back_top_widget.dart';
import 'package:tbk_app/widgets/product_list_view_widget.dart';
import 'package:url_launcher/url_launcher.dart';



class ProductDetail extends StatefulWidget {
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  var  product = Object();
  String productId = '588618803525';



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getProductInfo();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        reverse: false,
        slivers: <Widget>[
          SliverToBoxAdapter(child: null),
          SliverPersistentHeader(
            pinned: true, //是否固定在顶部
            floating: true,
            delegate: _SliverAppBarDelegate(
              maxHeight: 50.0,
              minHeight:  50.0,
              child: Container(
//            padding: EdgeInsets.only(left: 16),
                color: Colors.red,
//            alignment: Alignment.centerLeft,
//            child: Text("宝贝 详情 推荐", style: TextStyle(fontSize: 18)),
              ),
            ),
          ),
          SliverList(
              delegate:SliverChildListDelegate(
                  _sliverListChild()
              ),
          )
        ],
      ),
    );
  }


  void getProductInfo() {
    getHttpRes('getProductInfo', 'productId='+productId).then((val) {
      setState(() {
        ProductModel product = ProductModel.fromJson(val['data']['product']) ;

        print(product.toString());
      });
    });
  }
  List<Widget> _sliverListChild(){
    List<Widget> list = List();

//    list.add(SwiperDiy(swiperDataList: swiper),);
    list.add(Text("wwwww"));
    list.add(Text("wwwww"));
    list.add(Text("wwwww"));
    list.add(Text("wwwww"));
    list.add(Text("wwwww"));
    list.add(Text("wwwww"));
    list.add(Text("wwwww"));
    list.add(Text("wwwww"));
    list.add(Text("wwwww"));
    list.add(Text("wwwww"));
    return list;
  }

}

/// 首页轮播组件编写
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        index: 0,
        itemBuilder: (BuildContext context, int index) {
          return Image.network("${swiperDataList[index]['bannerImg']}",
              fit: BoxFit.fill);
        },
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
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