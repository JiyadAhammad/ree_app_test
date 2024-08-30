import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shortie/custom/custom_image_picker.dart';
import 'package:shortie/pages/preview_hash_tag_page/api/fetch_hash_tag_api.dart';
import 'package:shortie/pages/preview_hash_tag_page/model/fetch_hash_tag_model.dart';
import 'package:shortie/ui/image_picker_bottom_sheet_ui.dart';
import 'package:shortie/ui/loading_ui.dart';
import 'package:shortie/pages/upload_reels_page/api/upload_reels_api.dart';
import 'package:shortie/pages/upload_reels_page/model/upload_reels_model.dart';
import 'package:shortie/utils/database.dart';
import 'package:shortie/utils/enums.dart';
import 'package:shortie/utils/internet_connection.dart';
import 'package:shortie/utils/utils.dart';

class UploadReelsController extends GetxController {
  TextEditingController descriptionController = TextEditingController();

  UploadReelsModel? uploadReelsModel;

  int videoTime = 0;
  String videoUrl = "";
  String videoThumbnail = "";

  FetchHashTagModel? fetchHashTagModel;
  List<HashTagData> hastTagCollection = [];
  List<HashTagData> selectedHashTag = [];
  bool isLoadingHashTag = false;

  @override
  void onInit() {
    init();
    Utils.showLog("Upload Reels Controller Initialized...");
    super.onInit();
  }

  Future<void> init() async {
    final arguments = Get.arguments;
    Utils.showLog("Selected Video => $arguments");
    videoUrl = arguments["video"];
    videoThumbnail = arguments["image"];
    videoTime = arguments["time"];
  }

  Future<void> onGetHashTag() async {
    if (hastTagCollection.isEmpty) {
      isLoadingHashTag = true;
      hastTagCollection.clear();
      final fetchHashTagModel = await FetchHashTagApi.callApi(hashTag: "");
      if (fetchHashTagModel?.data != null) {
        hastTagCollection.addAll(fetchHashTagModel?.data ?? []);
        Utils.showLog("Hast Tag Collection Length => ${hastTagCollection.length}");
      }
      isLoadingHashTag = false;
      update(["onGetHashTag"]);
    }
  }

  void onSelectHastTag(int index) {
    if (selectedHashTag.contains(hastTagCollection[index])) {
      selectedHashTag.remove(hastTagCollection[index]);
      update(["onSelectHastTag"]);
    } else {
      selectedHashTag.add(hastTagCollection[index]);
      update(["onSelectHastTag"]);
    }
  }

  Future<void> onChangeThumbnail(BuildContext context) async {
    await ImagePickerBottomSheetUi.show(
      context: context,
      onClickCamera: () async {
        final imagePath = await CustomImagePicker.pickImage(ImageSource.camera);

        if (imagePath != null) {
          videoThumbnail = imagePath;
          update(["onChangeThumbnail"]);
        }
      },
      onClickGallery: () async {
        final imagePath = await CustomImagePicker.pickImage(ImageSource.gallery);

        if (imagePath != null) {
          videoThumbnail = imagePath;
          update(["onChangeThumbnail"]);
        }
      },
    );
  }

  void onCancelHashTag(int index) {
    selectedHashTag.removeAt(index);
    update(["onSelectHastTag"]);
  }

  Future<void> onUploadReels() async {
    // *** TODO *** => Validation Code...
    // if (descriptionController.text.trim().isEmpty) {
    //   Utils.showToast(EnumLocal.txtPleaseEnterCaption.name.tr);
    // } else if (selectedHashTag.isEmpty) {
    //   Utils.showToast(EnumLocal.txtPleaseSelectHashTag.name.tr);
    // } else {
    Utils.showLog("Reels Uploading...");
    if (InternetConnection.isConnect.value) {
      Get.dialog(PopScope(canPop: false, child: const LoadingUi()), barrierDismissible: false); // Start Loading...

      List<String> hashTagIds = [];

      for (int index = 0; index < selectedHashTag.length; index++) {
        hashTagIds.add(selectedHashTag[index].id.toString());
      }

      Utils.showLog("Hast Tag Id => $hashTagIds");

      uploadReelsModel = await UploadReelsApi.callApi(
        loginUserId: Database.loginUserId,
        videoImage: videoThumbnail,
        videoUrl: videoUrl,
        videoTime: videoTime.toString(),
        hashTag: hashTagIds.map((e) => "$e").join(',').toString(),
        caption: descriptionController.text,
      );

      if (uploadReelsModel?.status == true && uploadReelsModel?.data?.id != null) {
        Utils.showToast(EnumLocal.txtReelsUploadSuccessfully.name.tr);
        Get.close(2);
      } else if (uploadReelsModel?.status == false &&
          uploadReelsModel?.message == "your duration of Video greater than decided by the admin.") {
        Utils.showToast(uploadReelsModel?.message ?? "");
      } else {
        Utils.showToast(EnumLocal.txtSomeThingWentWrong.name.tr);
      }
      Get.back(); // Stop Loading...
    } else {
      Utils.showToast(EnumLocal.txtConnectionLost.name.tr);
      Utils.showLog("Internet Connection Lost !!");
    }
  }
  // }
}
