part of 'sahakara.dart';

class MyProfileVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  MyProfileVariablesBuilder(this._dataConnect, );
  Deserializer<MyProfileData> dataDeserializer = (dynamic json)  => MyProfileData.fromJson(jsonDecode(json));
  
  Future<QueryResult<MyProfileData, void>> execute() {
    return ref().execute();
  }

  QueryRef<MyProfileData, void> ref() {
    
    return _dataConnect.query("MyProfile", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class MyProfileUsers {
  final String id;
  final String? authUid;
  final String email;
  final String name;
  final EnumValue<AccountType> accountType;
  final EnumValue<AppLanguage> language;
  MyProfileUsers.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  authUid = json['authUid'] == null ? null : nativeFromJson<String>(json['authUid']),
  email = nativeFromJson<String>(json['email']),
  name = nativeFromJson<String>(json['name']),
  accountType = accountTypeDeserializer(json['accountType']),
  language = appLanguageDeserializer(json['language']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MyProfileUsers otherTyped = other as MyProfileUsers;
    return id == otherTyped.id && 
    authUid == otherTyped.authUid && 
    email == otherTyped.email && 
    name == otherTyped.name && 
    accountType == otherTyped.accountType && 
    language == otherTyped.language;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, authUid.hashCode, email.hashCode, name.hashCode, accountType.hashCode, language.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if (authUid != null) {
      json['authUid'] = nativeToJson<String?>(authUid);
    }
    json['email'] = nativeToJson<String>(email);
    json['name'] = nativeToJson<String>(name);
    json['accountType'] = 
    accountTypeSerializer(accountType)
    ;
    json['language'] = 
    appLanguageSerializer(language)
    ;
    return json;
  }

  MyProfileUsers({
    required this.id,
    this.authUid,
    required this.email,
    required this.name,
    required this.accountType,
    required this.language,
  });
}

@immutable
class MyProfileData {
  final List<MyProfileUsers> users;
  MyProfileData.fromJson(dynamic json):
  
  users = (json['users'] as List<dynamic>)
        .map((e) => MyProfileUsers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MyProfileData otherTyped = other as MyProfileData;
    return users == otherTyped.users;
    
  }
  @override
  int get hashCode => users.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['users'] = users.map((e) => e.toJson()).toList();
    return json;
  }

  MyProfileData({
    required this.users,
  });
}

