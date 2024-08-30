import 'dart:convert';

FetchProfilePostModel fetchProfilePostModelFromJson(String str) => FetchProfilePostModel.fromJson(json.decode(str));
String fetchProfilePostModelToJson(FetchProfilePostModel data) => json.encode(data.toJson());

class FetchProfilePostModel {
  FetchProfilePostModel({
    bool? status,
    String? message,
    List<ProfilePostData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchProfilePostModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ProfilePostData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<ProfilePostData>? _data;
  FetchProfilePostModel copyWith({
    bool? status,
    String? message,
    List<ProfilePostData>? data,
  }) =>
      FetchProfilePostModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<ProfilePostData>? get data => _data;

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

ProfilePostData dataFromJson(String str) => ProfilePostData.fromJson(json.decode(str));
String dataToJson(ProfilePostData data) => json.encode(data.toJson());

class ProfilePostData {
  ProfilePostData({
    String? id,
    String? mainPostImage,
    List<String>? postImage,
  }) {
    _id = id;
    _mainPostImage = mainPostImage;
    _postImage = postImage;
  }

  ProfilePostData.fromJson(dynamic json) {
    _id = json['_id'];
    _mainPostImage = json['mainPostImage'];
    _postImage = json['postImage'] != null ? json['postImage'].cast<String>() : [];
  }
  String? _id;
  String? _mainPostImage;
  List<String>? _postImage;
  ProfilePostData copyWith({
    String? id,
    String? mainPostImage,
    List<String>? postImage,
  }) =>
      ProfilePostData(
        id: id ?? _id,
        mainPostImage: mainPostImage ?? _mainPostImage,
        postImage: postImage ?? _postImage,
      );
  String? get id => _id;
  String? get mainPostImage => _mainPostImage;
  List<String>? get postImage => _postImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['mainPostImage'] = _mainPostImage;
    map['postImage'] = _postImage;
    return map;
  }
}
