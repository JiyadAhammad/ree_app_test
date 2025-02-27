import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shortie/custom/custom_format_number.dart';
import 'package:shortie/ui/loading_ui.dart';
import 'package:shortie/ui/no_data_found_ui.dart';
import 'package:shortie/pages/preview_hash_tag_page/controller/preview_hash_tag_controller.dart';
import 'package:shortie/pages/preview_hash_tag_page/widget/preview_hash_tag_widget.dart';

import 'package:shortie/utils/color.dart';

class PreviewHashTagView extends StatelessWidget {
  const PreviewHashTagView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorScaffold,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(102),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.white,
          shadowColor: AppColor.black.withOpacity(0.4),
          surfaceTintColor: AppColor.transparent,
          flexibleSpace: PreviewHashTagAppBar(
            title: ("#${Get.arguments["name"] ?? ""}"),
          ),
        ),
      ),
      body: GetBuilder<PreviewHashTagController>(
        id: "onChangeTabBar",
        builder: (logic) => PageView.builder(
          itemCount: 2,
          onPageChanged: (value) => logic.onChangeTabBar(value),
          itemBuilder: (context, index) => logic.searchTabPages[logic.selectedTabIndex],
        ),
      ),
    );
  }
}
