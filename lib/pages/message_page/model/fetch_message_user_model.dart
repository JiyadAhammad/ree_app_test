import 'dart:convert';

FetchMessageUserModel fetchMessageUserModelFromJson(String str) => FetchMessageUserModel.fromJson(json.decode(str));
String fetchMessageUserModelToJson(FetchMessageUserModel data) => json.encode(data.toJson());

class FetchMessageUserModel {
  FetchMessageUserModel({
    bool? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchMessageUserModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Data>? _data;
  FetchMessageUserModel copyWith({
    bool? status,
    String? message,
    List<Data>? data,
  }) =>
      FetchMessageUserModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

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

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? id,
    String? name,
    String? userName,
    String? image,
    bool? isOnline,
    bool? isVerified,
    String? userId,
    String? chatTopicId,
    String? senderUserId,
    String? message,
    int? unreadCount,
    String? time,
  }) {
    _id = id;
    _name = name;
    _userName = userName;
    _image = image;
    _isOnline = isOnline;
    _isVerified = isVerified;
    _userId = userId;
    _chatTopicId = chatTopicId;
    _senderUserId = senderUserId;
    _message = message;
    _unreadCount = unreadCount;
    _time = time;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _userName = json['userName'];
    _image = json['image'];
    _isOnline = json['isOnline'];
    _isVerified = json['isVerified'];
    _userId = json['userId'];
    _chatTopicId = json['chatTopicId'];
    _senderUserId = json['senderUserId'];
    _message = json['message'];
    _unreadCount = json['unreadCount'];
    _time = json['time'];
  }
  String? _id;
  String? _name;
  String? _userName;
  String? _image;
  bool? _isOnline;
  bool? _isVerified;
  String? _userId;
  String? _chatTopicId;
  String? _senderUserId;
  String? _message;
  int? _unreadCount;
  String? _time;
  Data copyWith({
    String? id,
    String? name,
    String? userName,
    String? image,
    bool? isOnline,
    bool? isVerified,
    String? userId,
    String? chatTopicId,
    String? senderUserId,
    String? message,
    int? unreadCount,
    String? time,
  }) =>
      Data(
        id: id ?? _id,
        name: name ?? _name,
        userName: userName ?? _userName,
        image: image ?? _image,
        isOnline: isOnline ?? _isOnline,
        isVerified: isVerified ?? _isVerified,
        userId: userId ?? _userId,
        chatTopicId: chatTopicId ?? _chatTopicId,
        senderUserId: senderUserId ?? _senderUserId,
        message: message ?? _message,
        unreadCount: unreadCount ?? _unreadCount,
        time: time ?? _time,
      );
  String? get id => _id;
  String? get name => _name;
  String? get userName => _userName;
  String? get image => _image;
  bool? get isOnline => _isOnline;
  bool? get isVerified => _isVerified;
  String? get userId => _userId;
  String? get chatTopicId => _chatTopicId;
  String? get senderUserId => _senderUserId;
  String? get message => _message;
  int? get unreadCount => _unreadCount;
  String? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['userName'] = _userName;
    map['image'] = _image;
    map['isOnline'] = _isOnline;
    map['isVerified'] = _isVerified;
    map['userId'] = _userId;
    map['chatTopicId'] = _chatTopicId;
    map['senderUserId'] = _senderUserId;
    map['message'] = _message;
    map['unreadCount'] = _unreadCount;
    map['time'] = _time;
    return map;
  }
}
