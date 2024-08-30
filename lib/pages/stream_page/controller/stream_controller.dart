import 'package:get/get.dart';
import 'package:shortie/pages/stream_page/api/fetch_live_user_api.dart';
import 'package:shortie/pages/stream_page/model/fetch_live_user_model.dart';
import 'package:shortie/utils/database.dart';
import 'package:shortie/utils/utils.dart';

class StreamController extends GetxController {
  Future<void> init() async {
    isLoading = true;
    FetchLiveUserApi.startPagination = 0;
    liveUsers.clear();
    update(["onGetLiveUser"]);
    await onGetLiveUser();
  }

  FetchLiveUserModel? fetchLiveUserModel;
  bool isLoading = false;
  List<LiveUserList> liveUsers = [];

  Future<void> onGetLiveUser() async {
    fetchLiveUserModel = await FetchLiveUserApi.callApi(loginUserId: Database.loginUserId);

    if (fetchLiveUserModel?.liveUserList?.isNotEmpty ?? false) {
      Utils.showLog("Live User Pagination Data Length => ${fetchLiveUserModel?.liveUserList}");

      liveUsers.addAll(fetchLiveUserModel?.liveUserList ?? []);
      update(["onGetLiveUser"]);
    }
    if (isLoading) {
      isLoading = false;

      update(["onGetLiveUser"]);
    }
  }
}
