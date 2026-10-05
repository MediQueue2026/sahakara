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
  final List<String>? preferredAreas;
  final List<EnumValue<AppLanguage>>? spokenLanguages;
  MyProfileUsers.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  authUid = json['authUid'] == null ? null : nativeFromJson<String>(json['authUid']),
  email = nativeFromJson<String>(json['email']),
  name = nativeFromJson<String>(json['name']),
  accountType = accountTypeDeserializer(json['accountType']),
  language = appLanguageDeserializer(json['language']),
  preferredAreas = json['preferredAreas'] == null ? null : (json['preferredAreas'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),
  spokenLanguages = json['spokenLanguages'] == null ? null : (json['spokenLanguages'] as List<dynamic>)
        .map((e) => appLanguageDeserializer(e))
        .toList();
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
    language == otherTyped.language && 
    preferredAreas == otherTyped.preferredAreas && 
    spokenLanguages == otherTyped.spokenLanguages;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, authUid.hashCode, email.hashCode, name.hashCode, accountType.hashCode, language.hashCode, preferredAreas.hashCode, spokenLanguages.hashCode]);
  

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
    if (preferredAreas != null) {
      json['preferredAreas'] = preferredAreas?.map((e) => nativeToJson<String>(e)).toList();
    }
    if (spokenLanguages != null) {
      json['spokenLanguages'] = spokenLanguages?.map((e) => appLanguageSerializer(e)).toList();
    }
    return json;
  }

  MyProfileUsers({
    required this.id,
    this.authUid,
    required this.email,
    required this.name,
    required this.accountType,
    required this.language,
    this.preferredAreas,
    this.spokenLanguages,
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

