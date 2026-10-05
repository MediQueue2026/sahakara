part of 'sahakara.dart';

class MaidProfileByEmailVariablesBuilder {
  String email;

  final FirebaseDataConnect _dataConnect;
  MaidProfileByEmailVariablesBuilder(this._dataConnect, {required  this.email,});
  Deserializer<MaidProfileByEmailData> dataDeserializer = (dynamic json)  => MaidProfileByEmailData.fromJson(jsonDecode(json));
  Serializer<MaidProfileByEmailVariables> varsSerializer = (MaidProfileByEmailVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<MaidProfileByEmailData, MaidProfileByEmailVariables>> execute() {
    return ref().execute();
  }

  QueryRef<MaidProfileByEmailData, MaidProfileByEmailVariables> ref() {
    MaidProfileByEmailVariables vars= MaidProfileByEmailVariables(email: email,);
    return _dataConnect.query("MaidProfileByEmail", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class MaidProfileByEmailUsers {
  final String name;
  final List<String>? preferredAreas;
  final List<EnumValue<AppLanguage>>? spokenLanguages;
  MaidProfileByEmailUsers.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']),
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

    final MaidProfileByEmailUsers otherTyped = other as MaidProfileByEmailUsers;
    return name == otherTyped.name && 
    preferredAreas == otherTyped.preferredAreas && 
    spokenLanguages == otherTyped.spokenLanguages;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, preferredAreas.hashCode, spokenLanguages.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    if (preferredAreas != null) {
      json['preferredAreas'] = preferredAreas?.map((e) => nativeToJson<String>(e)).toList();
    }
    if (spokenLanguages != null) {
      json['spokenLanguages'] = spokenLanguages?.map((e) => appLanguageSerializer(e)).toList();
    }
    return json;
  }

  MaidProfileByEmailUsers({
    required this.name,
    this.preferredAreas,
    this.spokenLanguages,
  });
}

@immutable
class MaidProfileByEmailData {
  final List<MaidProfileByEmailUsers> users;
  MaidProfileByEmailData.fromJson(dynamic json):
  
  users = (json['users'] as List<dynamic>)
        .map((e) => MaidProfileByEmailUsers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MaidProfileByEmailData otherTyped = other as MaidProfileByEmailData;
    return users == otherTyped.users;
    
  }
  @override
  int get hashCode => users.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['users'] = users.map((e) => e.toJson()).toList();
    return json;
  }

  MaidProfileByEmailData({
    required this.users,
  });
}

@immutable
class MaidProfileByEmailVariables {
  final String email;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  MaidProfileByEmailVariables.fromJson(Map<String, dynamic> json):
  
  email = nativeFromJson<String>(json['email']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MaidProfileByEmailVariables otherTyped = other as MaidProfileByEmailVariables;
    return email == otherTyped.email;
    
  }
  @override
  int get hashCode => email.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['email'] = nativeToJson<String>(email);
    return json;
  }

  MaidProfileByEmailVariables({
    required this.email,
  });
}

