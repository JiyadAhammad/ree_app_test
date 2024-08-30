import 'dart:convert';

FetchLiveUserModel fetchLiveUserModelFromJson(String str) => FetchLiveUserModel.fromJson(json.decode(str));
String fetchLiveUserModelToJson(FetchLiveUserModel data) => json.encode(data.toJson());

class FetchLiveUserModel {
  FetchLiveUserModel({
    bool? status,
    String? message,
    List<LiveUserList>? liveUserList,
  }) {
    _status = status;
    _message = message;
    _liveUserList = liveUserList;
  }

  FetchLiveUserModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['liveUserList'] != null) {
      _liveUserList = [];
      json['liveUserList'].forEach((v) {
        _liveUserList?.add(LiveUserList.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<LiveUserList>? _liveUserList;
  FetchLiveUserModel copyWith({
    bool? status,
    String? message,
    List<LiveUserList>? liveUserList,
  }) =>
      FetchLiveUserModel(
        status: status ?? _status,
        message: message ?? _message,
        liveUserList: liveUserList ?? _liveUserList,
      );
  bool? get status => _status;
  String? get message => _message;
  List<LiveUserList>? get liveUserList => _liveUserList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_liveUserList != null) {
      map['liveUserList'] = _liveUserList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

LiveUserList liveUserListFromJson(String str) => LiveUserList.fromJson(json.decode(str));
String liveUserListToJson(LiveUserList data) => json.encode(data.toJson());

class LiveUserList {
  LiveUserList({
    String? id,
    String? name,
    String? userName,
    String? image,
    String? countryFlagImage,
    bool? isLive,
    bool? isVerified,
    String? liveHistoryId,
    int? view,
    bool? isFollow,
  }) {
    _id = id;
    _name = name;
    _userName = userName;
    _image = image;
    _countryFlagImage = countryFlagImage;
    _isLive = isLive;
    _isVerified = isVerified;
    _liveHistoryId = liveHistoryId;
    _view = view;
    _isFollow = isFollow;
  }

  LiveUserList.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _userName = json['userName'];
    _image = json['image'];
    _countryFlagImage = json['countryFlagImage'];
    _isLive = json['isLive'];
    _isVerified = json['isVerified'];
    _liveHistoryId = json['liveHistoryId'];
    _view = json['view'];
    _isFollow = json['isFollow'];
  }
  String? _id;
  String? _name;
  String? _userName;
  String? _image;
  String? _countryFlagImage;
  bool? _isLive;
  bool? _isVerified;
  String? _liveHistoryId;
  int? _view;
  bool? _isFollow;
  LiveUserList copyWith({
    String? id,
    String? name,
    String? userName,
    String? image,
    String? countryFlagImage,
    bool? isLive,
    bool? isVerified,
    String? liveHistoryId,
    int? view,
    bool? isFollow,
  }) =>
      LiveUserList(
        id: id ?? _id,
        name: name ?? _name,
        userName: userName ?? _userName,
        image: image ?? _image,
        countryFlagImage: countryFlagImage ?? _countryFlagImage,
        isLive: isLive ?? _isLive,
        isVerified: isVerified ?? _isVerified,
        liveHistoryId: liveHistoryId ?? _liveHistoryId,
        view: view ?? _view,
        isFollow: isFollow ?? _isFollow,
      );
  String? get id => _id;
  String? get name => _name;
  String? get userName => _userName;
  String? get image => _image;
  String? get countryFlagImage => _countryFlagImage;
  bool? get isLive => _isLive;
  bool? get isVerified => _isVerified;
  String? get liveHistoryId => _liveHistoryId;
  int? get view => _view;
  bool? get isFollow => _isFollow;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['userName'] = _userName;
    map['image'] = _image;
    map['countryFlagImage'] = _countryFlagImage;
    map['isLive'] = _isLive;
    map['isVerified'] = _isVerified;
    map['liveHistoryId'] = _liveHistoryId;
    map['view'] = _view;
    map['isFollow'] = _isFollow;
    return map;
  }
}
