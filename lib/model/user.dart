import 'dart:convert';

User userModelFromJson(String str) {
  final jsonData = json.decode(str);
  return User.fromJson(jsonData);
}

String userModelToJson(User data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class User {
  String id;
  String username;
  List<Branch> branches;
  List<String> roles;
  Profile profile;
  String createdAt;
  dynamic tel;

  User({
    this.id,
    this.username,
    this.branches,
    this.roles,
    this.profile,
    this.createdAt,
    this.tel,
  });

  factory User.fromJson(Map<String, dynamic> json){
    return  new User(
      id: json["_id"],
      username: json["username"],
      branches: new List<Branch>.from(json['branches'].map ((x) => Branch.fromMap(x))),
      roles: new List<String>.from(json["roles"].map((x) => x)),
      profile: Profile.fromJson(json["profile"]),
      createdAt: json["createdAt"],
      tel: json["tel"],
    );
  }
  factory User.fromJsonDecoreCollection(Map<String, dynamic> json){
    return  new User(
      id: json["_id"],
      username: json["username"],
      roles: new List<String>.from(json["roles"].map((x) => x)),
      profile: Profile.fromJson(json["profile"]),
      createdAt: json["createdAt"],
      tel: json["tel"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "branches": new List<String>.from(branches.map((x) => x)),
    "roles": new List<String>.from(roles.map((x) => x)),
    "profile": profile.toJson(),
    "createdAt": createdAt,
    "tel": tel,
  };
  Map<String, dynamic> toJsonForDecore() => {
    "id": id,
    "username": username,
    "roles": new List<String>.from(roles.map((x) => x)),
    "profile": profile.toJson(),
    "createdAt": createdAt,
    "tel": tel,
  };
}
class Profile {
  bool approved;
  List<ProfileImageUrl> profileImageUrl;
  Profile({
    this.approved,
    this.profileImageUrl = const  []
  });

  factory Profile.fromJson(Map<String, dynamic> json) => new Profile(
      approved: json["approved"],
      profileImageUrl: json['imageUrl'] == null ? [] : List<ProfileImageUrl>.from(json['imageUrl'].map((map) => ProfileImageUrl.fromJson(map)))
  );

  Map<String, dynamic> toJson() => {
    "approved": approved,
  };
}

class Branch {
  final String id;
  final String name;
  final String shortcutName;
  final String baseCurrency;

  Branch({this.id, this.name, this.shortcutName,this.baseCurrency});

  factory Branch.fromMap(Map map) {
    return Branch(
        id: map['_id'],
        name: map['name'],
        baseCurrency: map['baseCurrency'],
        shortcutName: map['shortcutName']
    );

  }


}

class ProfileImageUrl {
  String url;
  String token;

  ProfileImageUrl({
    this.url,
    this.token,
  });

  factory ProfileImageUrl.fromJson(Map<String, dynamic> json) => new ProfileImageUrl(
    url: json["url"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "token": token,
  };
}