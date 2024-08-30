import 'dart:convert';

FetchProfileVideoModel fetchProfileVideoModelFromJson(String str) => FetchProfileVideoModel.fromJson(json.decode(str));
String fetchProfileVideoModelToJson(FetchProfileVideoModel data) => json.encode(data.toJson());

class FetchProfileVideoModel {
  FetchProfileVideoModel({
    bool? status,
    String? message,
    List<ProfileVideoData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchProfileVideoModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ProfileVideoData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<ProfileVideoData>? _data;
  FetchProfileVideoModel copyWith({
    bool? status,
    String? message,
    List<ProfileVideoData>? data,
  }) =>
      FetchProfileVideoModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<ProfileVideoData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

ProfileVideoData dataFromJson(String str) => ProfileVideoData.fromJson(json.decode(str));
String dataToJson(ProfileVideoData data) => json.encode(data.toJson());

class ProfileVideoData {
  ProfileVideoData({
    String? id,
    String? caption,
    String? videoUrl,
    String? videoImage,
    bool? isBanned,
    bool? isLike,
    int? totalLikes,
    int? totalComments,
    int? totalViews,
    List<String>? hashTag,
    String? userId,
    String? name,
    String? userName,
    String? userImage,
  }) {
    _id = id;
    _caption = caption;
    _videoUrl = videoUrl;
    _videoImage = videoImage;
    _isBanned = isBanned;
    _isLike = isLike;
    _totalLikes = totalLikes;
    _totalComments = totalComments;
    _totalViews = totalViews;
    _hashTag = hashTag;
    _userId = userId;
    _name = name;
    _userName = userName;
    _userImage = userImage;
  }

  ProfileVideoData.fromJson(dynamic json) {
    _id = json['_id'];
    _caption = json['caption'];
    _videoUrl = json['videoUrl'];
    _videoImage = json['videoImage'];
    _isBanned = json['isBanned'];
    _isLike = json['isLike'];
    _totalLikes = json['totalLikes'];
    _totalComments = json['totalComments'];
    _totalViews = json['totalViews'];
    _hashTag = json['hashTag'] != null ? json['hashTag'].cast<String>() : [];
    _userId = json['userId'];
    _name = json['name'];
    _userName = json['userName'];
    _userImage = json['userImage'];
  }
  String? _id;
  String? _caption;
  String? _videoUrl;
  String? _videoImage;
  bool? _isBanned;
  bool? _isLike;
  int? _totalLikes;
  int? _totalComments;
  int? _totalViews;
  List<String>? _hashTag;
  String? _userId;
  String? _name;
  String? _userName;
  String? _userImage;
  ProfileVideoData copyWith({
    String? id,
    String? caption,
    String? videoUrl,
    String? videoImage,
    bool? isBanned,
    bool? isLike,
    int? totalLikes,
    int? totalComments,
    int? totalViews,
    List<String>? hashTag,
    String? userId,
    String? name,
    String? userName,
    String? userImage,
  }) =>
      ProfileVideoData(
        id: id ?? _id,
        caption: caption ?? _caption,
        videoUrl: videoUrl ?? _videoUrl,
        videoImage: videoImage ?? _videoImage,
        isBanned: isBanned ?? _isBanned,
        isLike: isLike ?? _isLike,
        totalLikes: totalLikes ?? _totalLikes,
        totalComments: totalComments ?? _totalComments,
        totalViews: totalViews ?? _totalViews,
        hashTag: hashTag ?? _hashTag,
        userId: userId ?? _userId,
        name: name ?? _name,
        userName: userName ?? _userName,
        userImage: userImage ?? _userImage,
      );
  String? get id => _id;
  String? get caption => _caption;
  String? get videoUrl => _videoUrl;
  String? get videoImage => _videoImage;
  bool? get isBanned => _isBanned;
  bool? get isLike => _isLike;
  int? get totalLikes => _totalLikes;
  int? get totalComments => _totalComments;
  int? get totalViews => _totalViews;
  List<String>? get hashTag => _hashTag;
  String? get userId => _userId;
  String? get name => _name;
  String? get userName => _userName;
  String? get userImage => _userImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['caption'] = _caption;
    map['videoUrl'] = _videoUrl;
    map['videoImage'] = _videoImage;
    map['isBanned'] = _isBanned;
    map['isLike'] = _isLike;
    map['totalLikes'] = _totalLikes;
    map['totalComments'] = _totalComments;
    map['totalViews'] = _totalViews;
    map['hashTag'] = _hashTag;
    map['userId'] = _userId;
    map['name'] = _name;
    map['userName'] = _userName;
    map['userImage'] = _userImage;
    return map;
  }
}
