part of 'sahakara.dart';

class UserIdByPhoneVariablesBuilder {
  String phone;

  final FirebaseDataConnect _dataConnect;
  UserIdByPhoneVariablesBuilder(this._dataConnect, {required  this.phone,});
  Deserializer<UserIdByPhoneData> dataDeserializer = (dynamic json)  => UserIdByPhoneData.fromJson(jsonDecode(json));
  Serializer<UserIdByPhoneVariables> varsSerializer = (UserIdByPhoneVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<UserIdByPhoneData, UserIdByPhoneVariables>> execute() {
    return ref().execute();
  }

  QueryRef<UserIdByPhoneData, UserIdByPhoneVariables> ref() {
    UserIdByPhoneVariables vars= UserIdByPhoneVariables(phone: phone,);
    return _dataConnect.query("UserIdByPhone", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UserIdByPhoneUsers {
  final String id;
  UserIdByPhoneUsers.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UserIdByPhoneUsers otherTyped = other as UserIdByPhoneUsers;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UserIdByPhoneUsers({
    required this.id,
  });
}

@immutable
class UserIdByPhoneData {
  final List<UserIdByPhoneUsers> users;
  UserIdByPhoneData.fromJson(dynamic json):
  
  users = (json['users'] as List<dynamic>)
        .map((e) => UserIdByPhoneUsers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UserIdByPhoneData otherTyped = other as UserIdByPhoneData;
    return users == otherTyped.users;
    
  }
  @override
  int get hashCode => users.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['users'] = users.map((e) => e.toJson()).toList();
    return json;
  }

  UserIdByPhoneData({
    required this.users,
  });
}

@immutable
class UserIdByPhoneVariables {
  final String phone;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UserIdByPhoneVariables.fromJson(Map<String, dynamic> json):
  
  phone = nativeFromJson<String>(json['phone']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UserIdByPhoneVariables otherTyped = other as UserIdByPhoneVariables;
    return phone == otherTyped.phone;
    
  }
  @override
  int get hashCode => phone.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['phone'] = nativeToJson<String>(phone);
    return json;
  }

  UserIdByPhoneVariables({
    required this.phone,
  });
}

