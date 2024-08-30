import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shortie/shimmer/feed_shimmer_ui.dart';
import 'package:shortie/ui/no_data_found_ui.dart';
import 'package:shortie/pages/feed_page/controller/feed_controller.dart';
import 'package:shortie/pages/feed_page/widget/feed_widget.dart';
import 'package:shortie/utils/color.dart';
import 'package:shortie/utils/constant.dart';

class FeedView extends GetView<FeedController> {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.init();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.white,
        surfaceTintColor: AppColor.transparent,
        flexibleSpace: const FeedAppBarView(),
      ),
      body: RefreshIndicator(
        color: AppColor.primary,
        onRefresh: () async => controller.init(),
        child: SingleChildScrollView(
          child: SizedBox(
            // This Is Use To Active Refresh Indicator (25 - Extra Space)
            height: Get.height + 1 - AppConstant.bottomBarSize - 25,
            child: GetBuilder<FeedController>(
              id: "onGetPost",
              builder: (controller) => controller.isLoadingPost
                  ? FeedShimmerUi()
                  : controller.mainPost.isEmpty
                      ? const NoDataFoundUi(iconSize: 160, fontSize: 19)
                      : RefreshIndicator(
                          color: AppColor.primary,
                          onRefresh: () async => await controller.init(),
                          child: ListView.builder(
                            shrinkWrap: true,
                            controller: controller.scrollController,
                            itemCount: controller.mainPost.length,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              // if (index == controller.mainPost.length - 1) {
                              //   return SizedBox(
                              //     height: AppConstant.bottomBarSize.toDouble(),
                              //   );
                              // }
                              final post = controller.mainPost[index];
                              return PostView(
                                id: post.id ?? "",
                                userId: post.userId ?? "",
                                profileImage: post.userImage ?? "",
                                postImages: post.postImage ?? [],
                                title: post.name ?? "",
                                subTitle: post.userName ?? "",
                                isLike: post.isLike ?? false,
                                isFollow: post.isFollow ?? false,
                                isVerified: post.isVerified ?? false,
                                description: post.caption ?? "",
                                hastTag: post.hashTag ?? [],
                                time: post.time ?? "",
                                likes: post.totalLikes ?? 0,
                                comments: post.totalComments ?? 0,
                              );
                            },
                          ),
                        ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: GetBuilder<FeedController>(
        id: "onPagination",
        builder: (controller) => Visibility(
          visible: controller.isPaginationLoading,
          child: LinearProgressIndicator(color: AppColor.primary),
        ),
      ),
    );
  }
}
