import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shortie/ui/no_data_found_ui.dart';
import 'package:shortie/pages/reels_page/controller/reels_controller.dart';
import 'package:shortie/pages/reels_page/widget/reels_widget.dart';
import 'package:shortie/routes/app_routes.dart';
import 'package:shortie/shimmer/reels_shimmer_ui.dart';
import 'package:shortie/utils/color.dart';
import 'package:preload_page_view/preload_page_view.dart';

class ReelsView extends GetView<ReelsController> {
  const ReelsView({super.key});

  @override
  Widget build(BuildContext context) {
    if (Get.currentRoute == AppRoutes.bottomBarPage) {
      controller.init();
    }

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColor.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      body: GetBuilder<ReelsController>(
        id: "onGetReels",
        builder: (controller) => controller.isLoadingReels
            ? ReelsShimmerUi()
            : controller.mainReels.isEmpty
                ? const NoDataFoundUi(iconSize: 160, fontSize: 19)
                : PreloadPageView.builder(
                    controller: controller.preloadPageController,
                    itemCount: controller.mainReels.length,
                    preloadPagesCount: 4,
                    scrollDirection: Axis.vertical,
                    onPageChanged: (value) async {
                      controller.onPagination(value);
                      controller.onChangePage(value);
                    },
                    itemBuilder: (context, index) {
                      return GetBuilder<ReelsController>(
                        id: "onChangePage",
                        builder: (controller) => PreviewReelsView(
                          index: index,
                          currentPageIndex: controller.currentPageIndex,
                        ),
                      );
                    },
                  ),
      ),
      bottomNavigationBar: GetBuilder<ReelsController>(
        id: "onPagination",
        builder: (controller) => Visibility(
          visible: controller.isPaginationLoading,
          child: LinearProgressIndicator(color: AppColor.primary),
        ),
      ),
    );
  }
}
