import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BackTopButton extends StatelessWidget {

  ScrollController controller ;
  bool showToTopBtn ; //是否显示“返回到顶部”按钮

  BackTopButton({Key key,this.controller,this.showToTopBtn}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Offstage( /// 主程序
      offstage: !showToTopBtn,
      child: FloatingActionButton(
        backgroundColor: Colors.pink.withOpacity(0.7),
          child: Icon(Icons.arrow_upward,color: Colors.white,),
          onPressed: () {
            //返回到顶部时执行动画
            controller.animateTo(.0,
                duration: Duration(milliseconds: 200),
                curve: Curves.ease);
          }),
    );
  }
}

