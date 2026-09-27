part of 'sahakara.dart';

class SetMyLanguageVariablesBuilder {
  AppLanguage language;

  final FirebaseDataConnect _dataConnect;
  SetMyLanguageVariablesBuilder(this._dataConnect, {required  this.language,});
  Deserializer<SetMyLanguageData> dataDeserializer = (dynamic json)  => SetMyLanguageData.fromJson(jsonDecode(json));
  Serializer<SetMyLanguageVariables> varsSerializer = (SetMyLanguageVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<SetMyLanguageData, SetMyLanguageVariables>> execute() {
    return ref().execute();
  }

  MutationRef<SetMyLanguageData, SetMyLanguageVariables> ref() {
    SetMyLanguageVariables vars= SetMyLanguageVariables(language: language,);
    return _dataConnect.mutation("SetMyLanguage", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class SetMyLanguageData {
  final int user_updateMany;
  SetMyLanguageData.fromJson(dynamic json):
  
  user_updateMany = nativeFromJson<int>(json['user_updateMany']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SetMyLanguageData otherTyped = other as SetMyLanguageData;
    return user_updateMany == otherTyped.user_updateMany;
    
  }
  @override
  int get hashCode => user_updateMany.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['user_updateMany'] = nativeToJson<int>(user_updateMany);
    return json;
  }

  SetMyLanguageData({
    required this.user_updateMany,
  });
}

@immutable
class SetMyLanguageVariables {
  final AppLanguage language;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  SetMyLanguageVariables.fromJson(Map<String, dynamic> json):
  
  language = AppLanguage.values.byName(json['language']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SetMyLanguageVariables otherTyped = other as SetMyLanguageVariables;
    return language == otherTyped.language;
    
  }
  @override
  int get hashCode => language.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['language'] = 
    language.name
    ;
    return json;
  }

  SetMyLanguageVariables({
    required this.language,
  });
}

