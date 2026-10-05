part of 'sahakara.dart';

class SetMyProfileVariablesBuilder {
  String name;
  List<String> preferredAreas;
  List<AppLanguage> spokenLanguages;

  final FirebaseDataConnect _dataConnect;
  SetMyProfileVariablesBuilder(this._dataConnect, {required  this.name,required  this.preferredAreas,required  this.spokenLanguages,});
  Deserializer<SetMyProfileData> dataDeserializer = (dynamic json)  => SetMyProfileData.fromJson(jsonDecode(json));
  Serializer<SetMyProfileVariables> varsSerializer = (SetMyProfileVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<SetMyProfileData, SetMyProfileVariables>> execute() {
    return ref().execute();
  }

  MutationRef<SetMyProfileData, SetMyProfileVariables> ref() {
    SetMyProfileVariables vars= SetMyProfileVariables(name: name,preferredAreas: preferredAreas,spokenLanguages: spokenLanguages,);
    return _dataConnect.mutation("SetMyProfile", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class SetMyProfileData {
  final int user_updateMany;
  SetMyProfileData.fromJson(dynamic json):
  
  user_updateMany = nativeFromJson<int>(json['user_updateMany']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SetMyProfileData otherTyped = other as SetMyProfileData;
    return user_updateMany == otherTyped.user_updateMany;
    
  }
  @override
  int get hashCode => user_updateMany.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['user_updateMany'] = nativeToJson<int>(user_updateMany);
    return json;
  }

  SetMyProfileData({
    required this.user_updateMany,
  });
}

@immutable
class SetMyProfileVariables {
  final String name;
  final List<String> preferredAreas;
  final List<AppLanguage> spokenLanguages;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  SetMyProfileVariables.fromJson(Map<String, dynamic> json):
  
  name = nativeFromJson<String>(json['name']),
  preferredAreas = (json['preferredAreas'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),
  spokenLanguages = (json['spokenLanguages'] as List<dynamic>)
        .map((e) => AppLanguage.values.byName(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SetMyProfileVariables otherTyped = other as SetMyProfileVariables;
    return name == otherTyped.name && 
    preferredAreas == otherTyped.preferredAreas && 
    spokenLanguages == otherTyped.spokenLanguages;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, preferredAreas.hashCode, spokenLanguages.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['preferredAreas'] = preferredAreas.map((e) => nativeToJson<String>(e)).toList();
    json['spokenLanguages'] = spokenLanguages.map((e) => e.name).toList();
    return json;
  }

  SetMyProfileVariables({
    required this.name,
    required this.preferredAreas,
    required this.spokenLanguages,
  });
}

