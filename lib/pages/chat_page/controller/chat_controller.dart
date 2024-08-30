import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:shortie/custom/custom_image_picker.dart';
import 'package:shortie/pages/chat_page/api/fetch_user_chat_api.dart';
import 'package:shortie/pages/chat_page/api/send_file_api.dart';
import 'package:shortie/pages/chat_page/model/fetch_user_chat_model.dart';
import 'package:shortie/pages/chat_page/model/send_file_model.dart';
import 'package:shortie/ui/image_picker_bottom_sheet_ui.dart';
import 'package:shortie/utils/database.dart';
import 'package:shortie/utils/enums.dart';
import 'package:shortie/utils/socket_services.dart';
import 'package:shortie/utils/utils.dart';

class ChatController extends GetxController {
  TextEditingController messageController = TextEditingController();

  SendFileModel? sendFileModel;

  String receiverUserId = "";
  String receiverName = "";
  String receiverUserName = "";
  String receiverImage = "";

  String? chatRoomId;

  bool isLoading = false;
  bool isPaginationLoading = false;
  FetchUserChatModel? fetchUserChatModel;

  AudioRecorder audioRecorder = AudioRecorder();

  bool isRecordingAudio = false;

  RxBool isSendingAudioFile = false.obs;

  String currentPlayAudioId = ""; // This is use to one time only one play audio...

  Timer? timer;

  @override
  void onInit() {
    SocketServices.scrollController.addListener(onPagination);
    Utils.showLog("Chat Controller Initialize Success");

    receiverUserId = Get.arguments["id"] ?? "";
    receiverName = Get.arguments["name"] ?? "";
    receiverUserName = Get.arguments["userName"] ?? "";
    receiverImage = Get.arguments["image"] ?? "";

    SocketServices.lastVisitChatUserId = receiverUserId;

    init();

    super.onInit();
  }

  @override
  void onClose() {
    chatRoomId = null;
    SocketServices.userChats.clear();
    SocketServices.scrollController.removeListener(onPagination);
    SocketServices.lastVisitChatUserId = null;
    Utils.showLog("Chat Controller Dispose Success");
    super.onClose();
  }

  Future<void> init() async {
    if (receiverUserId != "") {
      chatRoomId = null;

      isLoading = true;
      update(["onGetUserChats"]);

      SocketServices.userChats.clear();
      FetchUserChatApi.startPagination = 0;

      await onGetUserChats();

      isLoading = false;
      update(["onGetUserChats"]);
    }
  }

  // >>>>> >>>>> >>>>> Get User Chat <<<<< <<<<< <<<<<

  Future<void> onGetUserChats() async {
    fetchUserChatModel =
        await FetchUserChatApi.callApi(senderUserId: Database.loginUserId, receiverUserId: receiverUserId);

    if (fetchUserChatModel?.chat != null) {
      final chats = (fetchUserChatModel?.chat) ?? [];

      Utils.showLog(
          "Fetch User Chat : Page Index => ${FetchUserChatApi.startPagination} : Page Length => ${chats.length}");

      if (chats.isNotEmpty) {
        SocketServices.userChats.insertAll(0, chats.reversed.toList());
        SocketServices.onUpdateChat();
      } else {
        FetchUserChatApi.startPagination--;
      }

      // >>>>> >>>>> Call Only First Time <<<<< <<<<<

      if (chatRoomId == null) {
        chatRoomId = fetchUserChatModel?.chatTopic;
        if (SocketServices.userChats.isNotEmpty) {
          SocketServices.onReadMessage(senderUserId: receiverUserId, messageId: SocketServices.userChats.last.id ?? "");
          SocketServices.onScrollDown();
        }
      }
    }
  }

  Future<void> onPagination() async {
    if (SocketServices.scrollController.position.pixels == SocketServices.scrollController.position.minScrollExtent) {
      isPaginationLoading = true;
      update(["onPagination"]);
      await onGetUserChats();
      isPaginationLoading = false;
      update(["onPagination"]);
    }
  }

  Future<void> onClickSend() async {
    if (messageController.text.trim().isNotEmpty) {
      onSendMessage(messageType: 1, message: messageController.text);
      messageController.clear();
    }
  }

  Future<void> onClickImage(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();

    await ImagePickerBottomSheetUi.show(
      context: context,
      onClickCamera: () async {
        final imagePath = await CustomImagePicker.pickImage(ImageSource.camera);

        if (imagePath != null) {
          onStaticInsertImage(imagePath);
        }
      },
      onClickGallery: () async {
        final imagePath = await CustomImagePicker.pickImage(ImageSource.gallery);

        if (imagePath != null) {
          onStaticInsertImage(imagePath);
        }
      },
    );
  }

  Future<void> onStaticInsertImage(String imagePath) async {
    SocketServices.userChats.add(
      Chat(
        messageType: 2,
        createdAt: DateTime.now().toString(),
        senderUserId: Database.loginUserId,
      ),
    ); // Static Show...

    SocketServices.onScrollDown();

    SocketServices.onUpdateChat();

    sendFileModel = await SendFileApi.callApi(
      senderUserId: Database.loginUserId,
      receiverUserId: receiverUserId,
      messageType: 2,
      filePath: imagePath,
    );

    SocketServices.userChats.removeLast(); // Static Show Remove...

    if (sendFileModel?.chat?.image != null) {
      onSendMessage(
          messageType: 2, message: sendFileModel?.chat?.image ?? "", messageId: sendFileModel?.chat?.id ?? "");
    }
  }

  Future<void> onSendMessage({required int messageType, required String message, String? messageId}) async {
    // Message Id => Use For Image & Audio File => Get On Send File Api...
    if (chatRoomId != null) {
      SocketServices.onSendMessage(
        senderUserId: Database.loginUserId,
        chatTopicId: chatRoomId!,
        messageType: messageType,
        messageText: message,
        image: message,
        audio: message,
        messageId: messageId, // This Variable in Pass Value iF User Send Image/Audio..
      );
    }
  }

  Future<void> onStartAudioRecording() async {
    Utils.showLog("Audio Recording Start");
    await audioRecorder.start(const RecordConfig(),
        path: "${(await getApplicationDocumentsDirectory()).path}/audio_${DateTime.now().millisecondsSinceEpoch}");
    isRecordingAudio = true;
    update(["onChangeAudioRecordingEvent"]);

    onChangeTimer();
  }

  Future<void> onLongPressStartMic() async {
    FocusManager.instance.primaryFocus?.unfocus();
    PermissionStatus status = await Permission.microphone.status;

    if (status.isDenied) {
      PermissionStatus request = await Permission.microphone.request();

      if (request == PermissionStatus.denied) {
        Utils.showToast(EnumLocal.txtPleaseAllowPermission.name.tr);
      }
    } else {
      Utils.showLog("Audio Recording Started...");
      onStartAudioRecording();
    }
  }

  Future<void> onLongPressEndMic() async {
    PermissionStatus status = await Permission.microphone.status;

    if (isRecordingAudio && status.isGranted) {
      onStopAudioRecording();
    }
  }

  Future<void> onStopAudioRecording() async {
    try {
      Utils.showLog("Audio Recording Stop");

      isSendingAudioFile.value = true;

      final audioPath = await audioRecorder.stop();

      isRecordingAudio = false;
      update(["onChangeAudioRecordingEvent"]);
      onChangeTimer();

      Utils.showLog("Recording Audio Path => $audioPath");

      if (audioPath != null) {
        SocketServices.userChats.add(
          Chat(
            messageType: 4,
            createdAt: DateTime.now().toString(),
            senderUserId: Database.loginUserId,
          ),
        ); // Static Show...

        SocketServices.onScrollDown();

        SocketServices.onUpdateChat();
      }

      await 3.seconds.delay();

      if (audioPath != null) {
        sendFileModel = await SendFileApi.callApi(
          senderUserId: Database.loginUserId,
          receiverUserId: receiverUserId,
          messageType: 3,
          filePath: audioPath,
        );
      }

      SocketServices.userChats.removeLast(); // Static Show Remove...

      if (sendFileModel?.chat?.audio != null) {
        onSendMessage(
            messageType: 3, message: sendFileModel?.chat?.audio ?? "", messageId: sendFileModel?.chat?.id ?? "");
      }
      isSendingAudioFile.value = false;
    } catch (e) {
      isSendingAudioFile.value = false;
      Utils.showLog("Audio Recording Stop Failed => $e");
    }
  }

  int countTime = 0;

  Future<void> onChangeTimer() async {
    if (isRecordingAudio && countTime == 0) {
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) async {
          countTime++;
          update(["onChangeAudioRecordingEvent"]);
          if (isRecordingAudio == false) {
            countTime = 0;
            this.timer?.cancel();
            update(["onChangeAudioRecordingEvent"]);
          }
        },
      );
    } else {
      countTime = 0;
      timer?.cancel();
      update(["onChangeAudioRecordingEvent"]);
    }
  }

  Future<void> onStaticInsertAudio(String imagePath) async {
    SocketServices.userChats.add(
      Chat(
        messageType: 2,
        createdAt: DateTime.now().toString(),
        senderUserId: Database.loginUserId,
      ),
    ); // Static Show...

    SocketServices.onScrollDown();

    SocketServices.onUpdateChat();

    sendFileModel = await SendFileApi.callApi(
      senderUserId: Database.loginUserId,
      receiverUserId: receiverUserId,
      messageType: 2,
      filePath: imagePath,
    );

    SocketServices.userChats.removeLast(); // Static Show Remove...

    if (sendFileModel?.chat?.image != null) {
      onSendMessage(
          messageType: 2, message: sendFileModel?.chat?.image ?? "", messageId: sendFileModel?.chat?.id ?? "");
    }
  }
}
