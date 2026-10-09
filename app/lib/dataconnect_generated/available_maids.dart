part of 'sahakara.dart';

class AvailableMaidsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  AvailableMaidsVariablesBuilder(this._dataConnect, );
  Deserializer<AvailableMaidsData> dataDeserializer = (dynamic json)  => AvailableMaidsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<AvailableMaidsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<AvailableMaidsData, void> ref() {
    
    return _dataConnect.query("AvailableMaids", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class AvailableMaidsUsers {
  final String id;
  final String name;
  final List<String>? preferredAreas;
  final List<EnumValue<AppLanguage>>? spokenLanguages;
  AvailableMaidsUsers.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
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

    final AvailableMaidsUsers otherTyped = other as AvailableMaidsUsers;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    preferredAreas == otherTyped.preferredAreas && 
    spokenLanguages == otherTyped.spokenLanguages;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, preferredAreas.hashCode, spokenLanguages.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    if (preferredAreas != null) {
      json['preferredAreas'] = preferredAreas?.map((e) => nativeToJson<String>(e)).toList();
    }
    if (spokenLanguages != null) {
      json['spokenLanguages'] = spokenLanguages?.map((e) => appLanguageSerializer(e)).toList();
    }
    return json;
  }

  AvailableMaidsUsers({
    required this.id,
    required this.name,
    this.preferredAreas,
    this.spokenLanguages,
  });
}

@immutable
class AvailableMaidsData {
  final List<AvailableMaidsUsers> users;
  AvailableMaidsData.fromJson(dynamic json):
  
  users = (json['users'] as List<dynamic>)
        .map((e) => AvailableMaidsUsers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AvailableMaidsData otherTyped = other as AvailableMaidsData;
    return users == otherTyped.users;
    
  }
  @override
  int get hashCode => users.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['users'] = users.map((e) => e.toJson()).toList();
    return json;
  }

  AvailableMaidsData({
    required this.users,
  });
}

