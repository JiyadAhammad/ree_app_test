import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:shortie/pages/bottom_bar_page/controller/bottom_bar_controller.dart';
import 'package:shortie/utils/asset.dart';
import 'package:shortie/utils/color.dart';
import 'package:shortie/utils/constant.dart';

class BottomBarUi extends StatelessWidget {
  const BottomBarUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarController>(
      id: "onChangeBottomBar",
      builder: (logic) {
        return SizedBox(
          height: AppConstant.bottomBarSize.toDouble(),
          width: Get.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _BottomBarIconUi(
                icon: logic.selectedTabIndex == 0
                    ? 'assets/png/film.png'
                    : 'assets/png/film.png',
                color: logic.selectedTabIndex == 0
                    ? AppColor.primaryLinearGradient
                    : null,
                callback: () => logic.onChangeBottomBar(0),
              ),
              _BottomBarIconUi(
                icon: logic.selectedTabIndex == 1
                    ? 'assets/png/live.png'
                    : 'assets/png/live.png',
                color: logic.selectedTabIndex == 1
                    ? AppColor.primaryLinearGradient
                    : null,
                callback: () => logic.onChangeBottomBar(1),
              ),
              _BottomBarIconUi(
                icon: logic.selectedTabIndex == 2
                    ? 'assets/png/fire.png'
                    : 'assets/png/fire.png',
                color: logic.selectedTabIndex == 2
                    ? AppColor.primaryLinearGradient
                    : null,
                callback: () => logic.onChangeBottomBar(2),
              ),
              _BottomBarIconUi(
                icon: logic.selectedTabIndex == 3
                    ? 'assets/png/chat.png'
                    : 'assets/png/chat.png',
                color: logic.selectedTabIndex == 3
                    ? AppColor.primaryLinearGradient
                    : null,
                callback: () => logic.onChangeBottomBar(3),
              ),
              _BottomBarIconUi(
                icon: logic.selectedTabIndex == 4
                    ? 'assets/png/profile-user.png'
                    : 'assets/png/profile-user.png',
                color: logic.selectedTabIndex == 4
                    ? AppColor.primaryLinearGradient
                    : null,
                callback: () => logic.onChangeBottomBar(4),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BottomBarIconUi extends StatelessWidget {
  const _BottomBarIconUi({
    required this.icon,
    required this.callback,
    required this.color,
  });

  final String icon;
  final Callback callback;
  final Gradient? color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: callback,
        child: Container(
          color: AppColor.transparent,
          child: Center(
            child: color == null
                ? Image.asset(
                    icon,
                    width: 25,
                    color: Colors.grey,
                  )
                : ShaderMask(
                    shaderCallback: (Rect bounds) {
                      final Rect rect = Rect.fromLTRB(0, 0, 20.0, 20.0);
                      return color!.createShader(rect);
                    },
                    child: Image.asset(
                      icon,
                      width: 25,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
