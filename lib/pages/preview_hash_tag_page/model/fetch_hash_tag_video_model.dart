import 'dart:convert';

FetchHashTagVideoModel fetchHashTagVideoModelFromJson(String str) => FetchHashTagVideoModel.fromJson(json.decode(str));
String fetchHashTagVideoModelToJson(FetchHashTagVideoModel data) => json.encode(data.toJson());

class FetchHashTagVideoModel {
  FetchHashTagVideoModel({
    bool? status,
    String? message,
    List<VideoData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchHashTagVideoModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(VideoData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<VideoData>? _data;
  FetchHashTagVideoModel copyWith({
    bool? status,
    String? message,
    List<VideoData>? data,
  }) =>
      FetchHashTagVideoModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<VideoData>? get data => _data;

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

VideoData dataFromJson(String str) => VideoData.fromJson(json.decode(str));
String dataToJson(VideoData data) => json.encode(data.toJson());

class VideoData {
  VideoData({
    String? id,
    bool? isLike,
    int? totalLikes,
    int? totalComments,
    String? videoId,
    String? videoImage,
    String? videoUrl,
    String? caption,
    String? userId,
    String? name,
    String? userName,
    String? userImage,
    bool? isVerified,
    List<String>? hashTag,
  }) {
    _id = id;
    _isLike = isLike;
    _totalLikes = totalLikes;
    _totalComments = totalComments;
    _videoId = videoId;
    _videoImage = videoImage;
    _videoUrl = videoUrl;
    _caption = caption;
    _userId = userId;
    _name = name;
    _userName = userName;
    _userImage = userImage;
    _isVerified = isVerified;
    _hashTag = hashTag;
  }

  VideoData.fromJson(dynamic json) {
    _id = json['_id'];
    _isLike = json['isLike'];
    _totalLikes = json['totalLikes'];
    _totalComments = json['totalComments'];
    _videoId = json['videoId'];
    _videoImage = json['videoImage'];
    _videoUrl = json['videoUrl'];
    _caption = json['caption'];
    _userId = json['userId'];
    _name = json['name'];
    _userName = json['userName'];
    _userImage = json['userImage'];
    _isVerified = json['isVerified'];
    _hashTag = json['hashTag'] != null ? json['hashTag'].cast<String>() : [];
  }
  String? _id;
  bool? _isLike;
  int? _totalLikes;
  int? _totalComments;
  String? _videoId;
  String? _videoImage;
  String? _videoUrl;
  String? _caption;
  String? _userId;
  String? _name;
  String? _userName;
  String? _userImage;
  bool? _isVerified;
  List<String>? _hashTag;
  VideoData copyWith({
    String? id,
    bool? isLike,
    int? totalLikes,
    int? totalComments,
    String? videoId,
    String? videoImage,
    String? videoUrl,
    String? caption,
    String? userId,
    String? name,
    String? userName,
    String? userImage,
    bool? isVerified,
    List<String>? hashTag,
  }) =>
      VideoData(
        id: id ?? _id,
        isLike: isLike ?? _isLike,
        totalLikes: totalLikes ?? _totalLikes,
        totalComments: totalComments ?? _totalComments,
        videoId: videoId ?? _videoId,
        videoImage: videoImage ?? _videoImage,
        videoUrl: videoUrl ?? _videoUrl,
        caption: caption ?? _caption,
        userId: userId ?? _userId,
        name: name ?? _name,
        userName: userName ?? _userName,
        userImage: userImage ?? _userImage,
        isVerified: isVerified ?? _isVerified,
        hashTag: hashTag ?? _hashTag,
      );
  String? get id => _id;
  bool? get isLike => _isLike;
  int? get totalLikes => _totalLikes;
  int? get totalComments => _totalComments;
  String? get videoId => _videoId;
  String? get videoImage => _videoImage;
  String? get videoUrl => _videoUrl;
  String? get caption => _caption;
  String? get userId => _userId;
  String? get name => _name;
  String? get userName => _userName;
  String? get userImage => _userImage;
  bool? get isVerified => _isVerified;
  List<String>? get hashTag => _hashTag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['isLike'] = _isLike;
    map['totalLikes'] = _totalLikes;
    map['totalComments'] = _totalComments;
    map['videoId'] = _videoId;
    map['videoImage'] = _videoImage;
    map['videoUrl'] = _videoUrl;
    map['caption'] = _caption;
    map['userId'] = _userId;
    map['name'] = _name;
    map['userName'] = _userName;
    map['userImage'] = _userImage;
    map['isVerified'] = _isVerified;
    map['hashTag'] = _hashTag;
    return map;
  }
}
