import 'dart:convert';

FetchProfileModel fetchProfileModelFromJson(String str) => FetchProfileModel.fromJson(json.decode(str));
String fetchProfileModelToJson(FetchProfileModel data) => json.encode(data.toJson());

class FetchProfileModel {
  FetchProfileModel({
    bool? status,
    String? message,
    UserProfileData? userProfileData,
  }) {
    _status = status;
    _message = message;
    _userProfileData = userProfileData;
  }

  FetchProfileModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _userProfileData = json['userProfileData'] != null ? UserProfileData.fromJson(json['userProfileData']) : null;
  }
  bool? _status;
  String? _message;
  UserProfileData? _userProfileData;
  FetchProfileModel copyWith({
    bool? status,
    String? message,
    UserProfileData? userProfileData,
  }) =>
      FetchProfileModel(
        status: status ?? _status,
        message: message ?? _message,
        userProfileData: userProfileData ?? _userProfileData,
      );
  bool? get status => _status;
  String? get message => _message;
  UserProfileData? get userProfileData => _userProfileData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_userProfileData != null) {
      map['userProfileData'] = _userProfileData?.toJson();
    }
    return map;
  }
}

UserProfileData userProfileDataFromJson(String str) => UserProfileData.fromJson(json.decode(str));
String userProfileDataToJson(UserProfileData data) => json.encode(data.toJson());

class UserProfileData {
  UserProfileData({
    User? user,
    int? totalFollowers,
    int? totalFollowing,
    int? totalLikesOfVideoPost,
  }) {
    _user = user;
    _totalFollowers = totalFollowers;
    _totalFollowing = totalFollowing;
    _totalLikesOfVideoPost = totalLikesOfVideoPost;
  }

  UserProfileData.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _totalFollowers = json['totalFollowers'];
    _totalFollowing = json['totalFollowing'];
    _totalLikesOfVideoPost = json['totalLikesOfVideoPost'];
  }
  User? _user;
  int? _totalFollowers;
  int? _totalFollowing;
  int? _totalLikesOfVideoPost;
  UserProfileData copyWith({
    User? user,
    int? totalFollowers,
    int? totalFollowing,
    int? totalLikesOfVideoPost,
  }) =>
      UserProfileData(
        user: user ?? _user,
        totalFollowers: totalFollowers ?? _totalFollowers,
        totalFollowing: totalFollowing ?? _totalFollowing,
        totalLikesOfVideoPost: totalLikesOfVideoPost ?? _totalLikesOfVideoPost,
      );
  User? get user => _user;
  int? get totalFollowers => _totalFollowers;
  int? get totalFollowing => _totalFollowing;
  int? get totalLikesOfVideoPost => _totalLikesOfVideoPost;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['totalFollowers'] = _totalFollowers;
    map['totalFollowing'] = _totalFollowing;
    map['totalLikesOfVideoPost'] = _totalLikesOfVideoPost;
    return map;
  }
}

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    String? name,
    String? userName,
    String? gender,
    String? image,
    String? countryFlagImage,
    String? country,
    bool? isFollow,
    bool? isVerified,
  }) {
    _name = name;
    _userName = userName;
    _gender = gender;
    _image = image;
    _countryFlagImage = countryFlagImage;
    _country = country;
    _isFollow = isFollow;
    _isVerified = isVerified;
  }

  User.fromJson(dynamic json) {
    _name = json['name'];
    _userName = json['userName'];
    _gender = json['gender'];
    _image = json['image'];
    _countryFlagImage = json['countryFlagImage'];
    _country = json['country'];
    _isFollow = json['isFollow'];
    _isVerified = json['isVerified'];
  }
  String? _name;
  String? _userName;
  String? _gender;
  String? _image;
  String? _countryFlagImage;
  String? _country;
  bool? _isFollow;
  bool? _isVerified;
  User copyWith({
    String? name,
    String? userName,
    String? gender,
    String? image,
    String? countryFlagImage,
    String? country,
    bool? isFollow,
    bool? isVerified,
  }) =>
      User(
        name: name ?? _name,
        userName: userName ?? _userName,
        gender: gender ?? _gender,
        image: image ?? _image,
        countryFlagImage: countryFlagImage ?? _countryFlagImage,
        country: country ?? _country,
        isFollow: isFollow ?? _isFollow,
        isVerified: isVerified ?? _isVerified,
      );
  String? get name => _name;
  String? get userName => _userName;
  String? get gender => _gender;
  String? get image => _image;
  String? get countryFlagImage => _countryFlagImage;
  String? get country => _country;
  bool? get isFollow => _isFollow;
  bool? get isVerified => _isVerified;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['userName'] = _userName;
    map['gender'] = _gender;
    map['image'] = _image;
    map['countryFlagImage'] = _countryFlagImage;
    map['country'] = _country;
    map['isFollow'] = _isFollow;
    map['isVerified'] = _isVerified;
    return map;
  }
}
