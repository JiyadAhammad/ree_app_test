import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shortie/main.dart';
import 'package:shortie/pages/login_page/controller/login_controller.dart';
import 'package:shortie/utils/asset.dart';
import 'package:shortie/utils/color.dart';
import 'package:shortie/utils/constant.dart';
import 'package:shortie/utils/enums.dart';
import 'package:shortie/utils/font_style.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(milliseconds: 300),
      () => SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: AppColor.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
    );
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AppAsset.imgLoginBg,
              height: Get.height, width: Get.width, fit: BoxFit.cover),
          Positioned(
            bottom: 0,
            child: Container(
              height: 600,
              width: Get.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColor.transparent,
                    AppColor.black,
                    AppColor.black,
                    AppColor.black
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/png/512X512 (1).png',
                    height: 180,
                    width: 180,
                  ),
                  25.height,
                  SizedBox(
                    width: Get.width / 1.2,
                    child: Text(
                      EnumLocal.txtLoginTitle.name.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 33,
                        color: AppColor.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w900,
                        fontFamily: AppConstant.appFontBold,
                      ),
                    ),
                  ),
                  5.height,
                  Text(
                    EnumLocal.txtLoginSubTitle.name.tr,
                    textAlign: TextAlign.center,
                    style: AppFontStyle.styleW400(AppColor.white, 14),
                  ),
                  20.height,
                  GestureDetector(
                    onTap: controller.onQuickLogin,
                    child: Container(
                      height: 56,
                      width: Get.width,
                      padding: EdgeInsets.only(left: 6, right: 52),
                      decoration: BoxDecoration(
                        gradient: AppColor.primaryLinearGradient,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 46,
                            width: 46,
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                                child: Image.asset(AppAsset.icQuickLogo,
                                    width: 24)),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                EnumLocal.txtQuickLogIn.name.tr,
                                style:
                                    AppFontStyle.styleW600(AppColor.white, 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  15.height,
                  GestureDetector(
                    onTap: controller.onGoogleLogin,
                    child: Container(
                      height: 56,
                      width: Get.width,
                      padding: EdgeInsets.only(left: 6, right: 52),
                      decoration: BoxDecoration(
                        color: AppColor.colorDarkPink,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 46,
                            width: 46,
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                                child: Image.asset(AppAsset.icGoogleLogo,
                                    width: 32)),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                EnumLocal.txtContinueWithGoogle.name.tr,
                                style:
                                    AppFontStyle.styleW600(AppColor.white, 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  10.height,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
