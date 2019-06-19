/*
 */

import 'dart:convert';

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
import 'package:flutter_html_widget/flutter_html_widget.dart';

class ProductDetail extends StatefulWidget {
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  ProductModel productModel = ProductModel();

  String productId = '588618803525';

  bool hidden = true;

  List productList = [];

  @override
  void initState() {
    super.initState();

    _getProductInfo();

    /// todo 商品推荐接口 暂时调用首页商品接口
    getHomePageGoods(1).then((val) {
      List list = val['data'];
      setState(() {
        productList.addAll(list);
      });
    });
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
              minHeight: 50.0,
              child: Container(
//            padding: EdgeInsets.only(left: 16),
                color: Colors.red,
//            alignment: Alignment.centerLeft,
//            child: Text("宝贝 详情 推荐", style: TextStyle(fontSize: 18)),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(_sliverListChild()),
          )
        ],
      ),
    );
  }

  void _getProductInfo() {
    getHttpRes('getProductInfo', 'productId=' + productId).then((val) {
      setState(() {
        productModel = ProductModel.fromJson(val['data']['product']);
        print(productModel.toString());
      });
    });
  }

  List<Widget> _sliverListChild() {
    List<Widget> list = List();

    list.add(SwiperDiy(list: productModel.smallImages));
    list.add(ProductInfomation(productModel));
    list.add(ShopInfomation(productModel));
    list.add(ItemDetails(productModel.numIid));
    list.add(ProductRecommend(productList.sublist(0, 6)));
    return list;
  }
}

/// 轮播组件编写
class SwiperDiy extends StatelessWidget {
  final List list;

  SwiperDiy({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(750),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        index: 0,
        itemBuilder: (BuildContext context, int index) {
          return Image.network("${list[index]}", fit: BoxFit.fill);
        },
        itemCount: list.length,
        pagination: new SwiperPagination(),
        autoplay: false,
      ),
    );
  }
}

/// 商品基础信息
class ProductInfomation extends StatelessWidget {
  ProductModel productModel;

  ProductInfomation([this.productModel]);

  Widget _row1() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              child: Text.rich(
            TextSpan(
              style: TextStyle(
                color: Colors.red,
                wordSpacing: 4,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(text: "券后价 ¥ ", style: TextStyle()),
                TextSpan(
                  text: productModel.afterCouponPrice,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          )),
          Container(
            padding: EdgeInsets.only(left: 3, right: 3, bottom: 1),
            decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2)),
            child: Text.rich(
              TextSpan(
                style: TextStyle(
                  color: Colors.red,
                  wordSpacing: 4,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(text: "预估收益:¥ ", style: TextStyle()),
                  TextSpan(
                    text: productModel.reservePrice,
                    style: TextStyle(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row2() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              child: Text.rich(
            TextSpan(
              text: "原价 ¥ " + productModel.zkFinalPrice,
              style: TextStyle(
                color: Colors.black38,
                wordSpacing: 4,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          )),
          Container(
            child: Text.rich(
              TextSpan(
                style: TextStyle(
                  color: Colors.black38,
                  wordSpacing: 4,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                      text: "已售" + productModel.tkTotalSales,
                      style: TextStyle()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row3() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            width: 25,
            padding: EdgeInsets.only(left: 3, right: 3, bottom: 0, top: 0.5),
            decoration: BoxDecoration(
                border: Border.all(width: 0.70, color: Colors.red),
                borderRadius: BorderRadius.circular(2)),
            child: Text(
              productModel.includeMkt ? "天猫" : "淘宝",
              style: TextStyle(fontSize: 8),
            ),
          ),
          Text(
            "          " + productModel.title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _row4() {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        padding: EdgeInsets.only(left: 3, right: 3, bottom: 1),
        decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(left: 5),
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(
                      color: Colors.pink,
                      fontSize: 9,
                    ),
                    children: [
                      TextSpan(text: "升级运营商，即可获得更高收益", style: TextStyle()),
                    ],
                  ),
                )),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "了解详情",
                      style: TextStyle(color: Colors.pink, fontSize: 9),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    padding: EdgeInsets.only(left: 3, right: 3, bottom: 1),
                    decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      ">",
                      style: TextStyle(color: Colors.pink, fontSize: 6),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Column(
        children: <Widget>[
          _row1(),
          _row2(),
          _row3(),
          _row4(),
        ],
      ),
    );
  }
}

/// 店铺基础信息
class ShopInfomation extends StatelessWidget {
  ProductModel productModel;

  ShopInfomation([this.productModel]);

  Widget _row1() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              child: Stack(
            children: <Widget>[
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://b-ssl.duitang.com/uploads/item/201601/08/20160108194244_JxGRy.thumb.700_0.jpeg"),
                    ),
                    borderRadius: BorderRadius.circular(7)),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 40, top: 7),
                child: Text(
                  "七公主旗舰店",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )),
          Container(
            child: Text.rich(
              TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  wordSpacing: 4,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(text: "进入店铺", style: TextStyle()),
                  TextSpan(
                    text: ">",
                    style: TextStyle(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row2Child(String v1, String v2, String v3) {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.zero,
            child: Text(
              v1,
              style: TextStyle(
                color: Colors.black,
                wordSpacing: 4,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 3),
            child: Text(
              v2,
              style: TextStyle(
                color: Colors.green,
                wordSpacing: 4,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 3),
            padding: EdgeInsets.only(left: 1, right: 1),
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(2)),
            child: Text(
              v3,
              style: TextStyle(
                color: Colors.white,
                wordSpacing: 4,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _row2() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _row2Child("宝贝描述", "4.8", "低"),
          _row2Child("卖家服务", "4.8", "低"),
          _row2Child("物流服务", "4.8", "低"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
      child: Column(
        children: <Widget>[
          _row1(),
          _row2(),
        ],
      ),
    );
  }
}

/// 商品详情页
class ItemDetails extends StatefulWidget {
  String productId;

  ItemDetails(this.productId);

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

/// 商品详情页 State
class _ItemDetailsState extends State<ItemDetails> {
  bool hidden;
  String richText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hidden = true;
    richText = '';
  }

  void _getItemDeatilRichText() {
    if (richText == '' || richText == null) {
      getHttpRes('getProductDetail', 'data=%7B"id":"' + '588618803525' + '"%7D')
          .then((val) {
        setState(() {
          hidden = !hidden;
          richText = val['data']['pcDescContent'].toString();
        });
      });
    } else {
      setState(() {
        hidden = !hidden;
      });
    }
  }

  Widget _itemDetailsTexg() {
    return InkWell(
      onTap: _getItemDeatilRichText,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Text("查看详情"),
            ),
            Container(
              child: Text(hidden ? ">" : "<"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemDeatilRichText() {
    return Container(
      child: Offstage(
        offstage: hidden,
        child: HtmlWidget(html: richText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
      child: Column(
        children: <Widget>[
          _itemDetailsTexg(),
          _itemDeatilRichText(),
        ],
      ),
    );
  }
}

/// 猜你喜欢

class ProductRecommend extends StatelessWidget {
  List list;

  ProductRecommend(this.list);

  Widget _recommendText() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 60,
          height: 1,
          color: Colors.red,
        ),
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Icon(
            Icons.video_label,
            size: 20,
            color: Colors.cyan,
            textDirection: TextDirection.ltr,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(
            "猜你喜欢",
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20),
          width: 60,
          height: 1,
          color: Colors.red,
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
      child: Column(
        children: <Widget>[
          _recommendText(),
          ProductListListView(list: list),
        ],
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
