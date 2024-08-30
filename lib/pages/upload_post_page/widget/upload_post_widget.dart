import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shortie/custom/custom_format_number.dart';
import 'package:shortie/shimmer/hash_tag_bottom_sheet_shimmer_ui.dart';
import 'package:shortie/ui/no_data_found_ui.dart';
import 'package:shortie/main.dart';
import 'package:shortie/pages/upload_post_page/controller/upload_post_controller.dart';
import 'package:shortie/utils/asset.dart';
import 'package:shortie/utils/color.dart';
import 'package:shortie/utils/enums.dart';
import 'package:shortie/utils/font_style.dart';

void postHashTagBottomSheet() {
  final controller = Get.find<UploadPostController>();
  controller.onGetHashTag();

  Get.bottomSheet(
    Container(
      height: Get.height / 2,
      width: Get.width,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 60,
            color: AppColor.grey_100,
            child: Padding(
              padding: const EdgeInsets.only(left: 0, right: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.transparent,
                          ),
                          child: Center(
                            child: Image.asset(
                              AppAsset.icArrowLeft,
                              color: AppColor.black,
                              width: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        EnumLocal.txtAddHashtag.name.tr,
                        style: AppFontStyle.styleW700(AppColor.black, 17),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 36,
                      width: 82,
                      decoration: BoxDecoration(
                        gradient: AppColor.primaryLinearGradient,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          EnumLocal.txtDone.name.tr,
                          style: AppFontStyle.styleW600(AppColor.white, 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GetBuilder<UploadPostController>(
              id: "onGetHashTag",
              builder: (controller) => controller.isLoadingHashTag
                  ? HashTagBottomSheetShimmerUi()
                  : controller.hastTagCollection.isEmpty
                      ? const NoDataFoundUi(iconSize: 160, fontSize: 19)
                      : ListView.builder(
                          itemCount: controller.hastTagCollection.length,
                          itemBuilder: (context, index) => GetBuilder<UploadPostController>(
                            id: "onSelectHastTag",
                            builder: (controller) => GestureDetector(
                              onTap: () => controller.onSelectHastTag(index),
                              child: Container(
                                height: 70,
                                width: Get.width,
                                padding: EdgeInsets.only(left: 20, right: 20),
                                decoration: BoxDecoration(
                                  border: Border(top: BorderSide(color: AppColor.grey_100)),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1.5,
                                          color:
                                              controller.selectedHashTag.contains(controller.hastTagCollection[index])
                                                  ? AppColor.primary
                                                  : AppColor.grey_300,
                                        ),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: controller.selectedHashTag.contains(controller.hastTagCollection[index])
                                          ? const Center(
                                              child: Icon(
                                                size: 15,
                                                Icons.done_rounded,
                                                color: AppColor.primary,
                                              ),
                                            )
                                          : const Offstage(),
                                    ),
                                    15.width,
                                    RichText(
                                      text: TextSpan(
                                        text: "# ",
                                        style: AppFontStyle.styleW600(AppColor.primary, 20),
                                        children: [
                                          TextSpan(
                                            text: controller.hastTagCollection[index].hashTag,
                                            style: AppFontStyle.styleW700(AppColor.black, 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        Image.asset(
                                          AppAsset.icViewBorder,
                                          color: AppColor.colorTextGrey,
                                          width: 20,
                                        ),
                                        5.width,
                                        Text(
                                          CustomFormatNumber.convert(
                                              controller.hastTagCollection[index].totalHashTagUsedCount ?? 0),
                                          style: AppFontStyle.styleW700(AppColor.colorTextGrey, 13),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
            ),
          ),
        ],
      ),
    ),
  );
}
