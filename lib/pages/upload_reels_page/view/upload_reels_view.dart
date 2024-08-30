import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shortie/ui/app_button_ui.dart';
import 'package:shortie/main.dart';
import 'package:shortie/pages/upload_reels_page/controller/upload_reels_controller.dart';
import 'package:shortie/pages/upload_reels_page/widget/upload_reels_widget.dart';
import 'package:shortie/ui/simple_app_bar_ui.dart';
import 'package:shortie/utils/asset.dart';
import 'package:shortie/utils/color.dart';
import 'package:shortie/utils/enums.dart';
import 'package:shortie/utils/font_style.dart';

class UploadReelsView extends StatelessWidget {
  const UploadReelsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UploadReelsController>();
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.white,
        shadowColor: AppColor.black.withOpacity(0.4),
        surfaceTintColor: AppColor.transparent,
        flexibleSpace: SimpleAppBarUi(title: EnumLocal.txtUploadReels.name.tr),
      ),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    15.height,
                    Container(
                      height: 210,
                      width: 160,
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                        color: AppColor.colorBorder.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: SizedBox(
                        height: 210,
                        width: 160,
                        child: GetBuilder<UploadReelsController>(id: "onChangeThumbnail", builder: (controller) => Image.file(File(controller.videoThumbnail), fit: BoxFit.cover)),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      margin: const EdgeInsets.only(bottom: 10, top: 10),
                      color: AppColor.colorBorder.withOpacity(0.2),
                      child: TextFormField(
                        maxLines: 5,
                        style: AppFontStyle.styleW600(AppColor.black, 15),
                        controller: controller.descriptionController,
                        cursorColor: AppColor.primary,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: EnumLocal.txtWhatsOnYourMind.name.tr,
                          hintStyle: AppFontStyle.styleW400(AppColor.coloGreyText, 15),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => controller.onChangeThumbnail(context),
                      child: Container(
                        height: 50,
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: AppColor.transparent,
                          border: Border.symmetric(
                            horizontal: BorderSide(color: AppColor.colorBorderGrey.withOpacity(0.6)),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(AppAsset.icChangeThumbnail, width: 20, color: AppColor.primary),
                            15.width,
                            Text(
                              EnumLocal.txtChangeThumbnail.name.tr,
                              style: AppFontStyle.styleW700(AppColor.black, 15),
                            ),
                            Spacer(),
                            Image.asset(AppAsset.icArrowRight, width: 20),
                          ],
                        ),
                      ),
                    ),
                    10.height,
                    InkWell(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        reelsHashTagBottomSheet();
                      },
                      child: Container(
                        height: 50,
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: AppColor.transparent,
                          border: Border.symmetric(
                            horizontal: BorderSide(color: AppColor.colorBorderGrey.withOpacity(0.6)),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "#",
                              style: AppFontStyle.styleW600(AppColor.primary, 24),
                            ),
                            18.width,
                            Text(
                              EnumLocal.txtAddTopic.name.tr,
                              style: AppFontStyle.styleW700(AppColor.black, 15),
                            ),
                            Spacer(),
                            Image.asset(AppAsset.icArrowRight, width: 20),
                          ],
                        ),
                      ),
                    ),
                    10.height,
                    GetBuilder<UploadReelsController>(
                      id: "onSelectHastTag",
                      builder: (logic) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Wrap(
                          spacing: 15,
                          alignment: WrapAlignment.start,
                          children: [
                            for (int index = 0; index < logic.selectedHashTag.length; index++)
                              Chip(
                                padding: const EdgeInsets.only(top: 7, bottom: 7, right: 7),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                deleteIconColor: AppColor.black,
                                onDeleted: () => logic.onCancelHashTag(index),
                                elevation: 0,
                                autofocus: false,
                                deleteIcon: Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Image.asset(AppAsset.icClose),
                                ),
                                backgroundColor: AppColor.grey_100,
                                side: const BorderSide(width: 0.8, color: AppColor.transparent),
                                label: RichText(
                                  text: TextSpan(
                                    text: " # ",
                                    style: AppFontStyle.styleW600(AppColor.primary, 16),
                                    children: [
                                      TextSpan(
                                        text: logic.selectedHashTag[index].hashTag,
                                        style: AppFontStyle.styleW700(AppColor.black, 13),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AppButtonUi(
            title: EnumLocal.txtUpload.name.tr,
            gradient: AppColor.primaryLinearGradient,
            callback: () {
              FocusManager.instance.primaryFocus?.unfocus();
              controller.onUploadReels();
            },
          ).paddingSymmetric(horizontal: Get.width / 6.5, vertical: 25),
        ],
      ),
    );
  }
}
