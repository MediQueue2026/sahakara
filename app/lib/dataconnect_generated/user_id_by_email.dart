part of 'sahakara.dart';

class UserIdByEmailVariablesBuilder {
  String email;

  final FirebaseDataConnect _dataConnect;
  UserIdByEmailVariablesBuilder(this._dataConnect, {required  this.email,});
  Deserializer<UserIdByEmailData> dataDeserializer = (dynamic json)  => UserIdByEmailData.fromJson(jsonDecode(json));
  Serializer<UserIdByEmailVariables> varsSerializer = (UserIdByEmailVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<UserIdByEmailData, UserIdByEmailVariables>> execute() {
    return ref().execute();
  }

  QueryRef<UserIdByEmailData, UserIdByEmailVariables> ref() {
    UserIdByEmailVariables vars= UserIdByEmailVariables(email: email,);
    return _dataConnect.query("UserIdByEmail", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UserIdByEmailUsers {
  final String id;
  UserIdByEmailUsers.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UserIdByEmailUsers otherTyped = other as UserIdByEmailUsers;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UserIdByEmailUsers({
    required this.id,
  });
}

@immutable
class UserIdByEmailData {
  final List<UserIdByEmailUsers> users;
  UserIdByEmailData.fromJson(dynamic json):
  
  users = (json['users'] as List<dynamic>)
        .map((e) => UserIdByEmailUsers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UserIdByEmailData otherTyped = other as UserIdByEmailData;
    return users == otherTyped.users;
    
  }
  @override
  int get hashCode => users.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['users'] = users.map((e) => e.toJson()).toList();
    return json;
  }

  UserIdByEmailData({
    required this.users,
  });
}

@immutable
class UserIdByEmailVariables {
  final String email;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UserIdByEmailVariables.fromJson(Map<String, dynamic> json):
  
  email = nativeFromJson<String>(json['email']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UserIdByEmailVariables otherTyped = other as UserIdByEmailVariables;
    return email == otherTyped.email;
    
  }
  @override
  int get hashCode => email.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['email'] = nativeToJson<String>(email);
    return json;
  }

  UserIdByEmailVariables({
    required this.email,
  });
}

