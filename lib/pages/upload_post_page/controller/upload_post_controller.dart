import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shortie/custom/custom_image_picker.dart';
import 'package:shortie/custom/custom_multi_image_picker.dart';
import 'package:shortie/pages/preview_hash_tag_page/api/fetch_hash_tag_api.dart';
import 'package:shortie/pages/preview_hash_tag_page/model/fetch_hash_tag_model.dart';
import 'package:shortie/ui/image_picker_bottom_sheet_ui.dart';
import 'package:shortie/ui/loading_ui.dart';
import 'package:shortie/pages/upload_post_page/api/upload_post_api.dart';
import 'package:shortie/pages/upload_post_page/model/upload_post_model.dart';
import 'package:shortie/utils/database.dart';
import 'package:shortie/utils/enums.dart';
import 'package:shortie/utils/internet_connection.dart';
import 'package:shortie/utils/utils.dart';

class UploadPostController extends GetxController {
  List<String> selectedImages = [];
  UploadPostModel? uploadPostModel;

  // bool isLoadingHashTag = false;
  //
  // bool isShowHashTag = false;
  // List<HashTagData> selectedHashTag = [];
  // List<HashTagData> hastTagCollection = [];
  // FetchHashTagModel? fetchHashTagModel;
  // TextEditingController captionController = TextEditingController();
  // TextEditingController hashTagController = TextEditingController();
  //
  // CreateHashTagModel? createHashTagModel;

  FetchHashTagModel? fetchHashTagModel;
  List<HashTagData> hastTagCollection = [];
  List<HashTagData> selectedHashTag = [];
  bool isLoadingHashTag = false;

  TextEditingController descriptionController = TextEditingController();

  @override
  void onInit() {
    init();
    super.onInit();

    Utils.showLog("Upload Post Controller Initialized...");
  }

  Future<void> init() async {
    Utils.showLog(
        "Selected Images Length => ${Get.arguments["images"].length}");

    if (Get.arguments["images"] != null) {
      selectedImages.addAll(Get.arguments["images"]);
    }
    onGetHashTag();
    // createHashTagModel = null;
  }

  Future<void> onGetHashTag() async {
    if (hastTagCollection.isEmpty) {
      isLoadingHashTag = true;
      hastTagCollection.clear();
      final fetchHashTagModel = await FetchHashTagApi.callApi(hashTag: "");
      if (fetchHashTagModel?.data != null) {
        hastTagCollection.addAll(fetchHashTagModel?.data ?? []);
        Utils.showLog(
            "Hast Tag Collection Length => ${hastTagCollection.length}");
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

  void onCancelHashTag(int index) {
    selectedHashTag.removeAt(index);
    update(["onSelectHastTag"]);
  }
  //
  // Future<void> onToggleHashTag(bool value) async {
  //   isShowHashTag = value;
  //   update(["onToggleHashTag"]);
  //
  //   if (value) {
  //     onGetHashTag();
  //   }
  // }
  //
  // Future<void> onCreateHashTag() async {
  //   onToggleHashTag(false);
  //   FocusManager.instance.primaryFocus?.unfocus();
  //
  //   Get.dialog(const LoadingUi(), barrierDismissible: false); // Start Loading...
  //
  //   createHashTagModel = await CreateHashTagApi.callApi(hashTag: hashTagController.text.trim());
  //   if (createHashTagModel?.data?.id != null) {
  //     Utils.showLog("Create Hast Tag Success ${createHashTagModel?.data?.id}");
  //
  //     selectedHashTag.add(
  //       HashTagData(
  //         id: createHashTagModel?.data?.id,
  //         hashTag: createHashTagModel?.data?.hashTag,
  //       ),
  //     );
  //     update(["onSelectHastTag"]);
  //
  //     hashTagController.clear();
  //   }
  //   Get.back(); // Stop Loading...
  // }
  //
  // Future<void> onGetHashTag() async {
  //   isLoadingHashTag = true;
  //   update(["onGetHashTag"]);
  //   fetchHashTagModel = await FetchHashTagApi.callApi(hashTag: hashTagController.text);
  //
  //   if (fetchHashTagModel?.data != null) {
  //     hastTagCollection.clear();
  //     hastTagCollection.addAll(fetchHashTagModel?.data ?? []);
  //     Utils.showLog("Hast Tag Collection Length => ${hastTagCollection.length}");
  //   }
  //   isLoadingHashTag = false;
  //   update(["onGetHashTag"]);
  // }
  //
  // void onSelectHastTag(int index) {
  //   selectedHashTag.add(hastTagCollection[index]);
  //   update(["onSelectHastTag"]);
  //
  //   onToggleHashTag(false);
  //   hashTagController.clear();
  //   FocusManager.instance.primaryFocus?.unfocus();
  // }
  //
  // void onCancelHashTag(int index) {
  //   selectedHashTag.removeAt(index);
  //   update(["onSelectHastTag"]);
  // }

  void onCancelImage(int index) {
    selectedImages.removeAt(index);
    update(["onChangeImages"]);
  }

  void onSelectNewImage(BuildContext context) async {
    await ImagePickerBottomSheetUi.show(
      context: context,
      onClickGallery: () async {
        final List<String> images =
            await CustomMultiImagePicker.pickImageOnly();

        if (images.isNotEmpty) {
          for (int i = 0; i < images.length; i++) {
            if (selectedImages.length < 5) {
              selectedImages.add(images[i]);
            } else {
              break;
            }
          }
          update(["onChangeImages"]);
        }
      },
      onClickCamera: () async {
        final String? imagePath =
            await CustomImagePicker.pickImage(ImageSource.camera);
        if (imagePath != null) {
          selectedImages.add(imagePath);
          update(["onChangeImages"]);
        }
      },
    );
  }

  Future<void> onUploadPost() async {
    // *** TODO *** => Validation Code...
    if (selectedImages.isEmpty) {
      Utils.showToast(EnumLocal.txtPleaseSelectPost.name.tr);
      // } else if (descriptionController.text.trim().isEmpty) {
      //   Utils.showToast(EnumLocal.txtPleaseEnterCaption.name.tr);
      // } else if (selectedHashTag.isEmpty) {
      //   Utils.showToast(EnumLocal.txtPleaseSelectHashTag.name.tr);
    } else {
      Utils.showLog(EnumLocal.txtPostUploading.name.tr);
      if (InternetConnection.isConnect.value) {
        Get.dialog(PopScope(canPop: false, child: const LoadingUi()),
            barrierDismissible: false); // Start Loading...

        List<String> hashTagIds = [];

        for (int index = 0; index < selectedHashTag.length; index++) {
          hashTagIds.add(selectedHashTag[index].id.toString());
        }

        Utils.showLog("Hast Tag Id => $hashTagIds");

        uploadPostModel = await UploadPostApi.callApi(
          loginUserId: Database.loginUserId,
          hashTag: hashTagIds.map((e) => "$e").join(',').toString(),
          caption: descriptionController.text,
          postImages: selectedImages,
        );

        if (uploadPostModel?.status == true &&
            uploadPostModel?.post?.id != null) {
          Utils.showToast(EnumLocal.txtPostUploadSuccessfully.name.tr);
          Get.close(2);
        } else {
          Utils.showToast(EnumLocal.txtSomeThingWentWrong.name.tr);
        }
        Get.back(); // Stop Loading...
      } else {
        Utils.showToast(EnumLocal.txtConnectionLost.name.tr);
        Utils.showLog("Internet Connection Lost !!");
      }
    }
  }
}

// if (selectedHashTag.contains(hastTagCollection[index])) {
//   selectedHashTag.remove(hastTagCollection[index]);
//   update(["onSelectHastTag"]);
// } else {
//
// }
