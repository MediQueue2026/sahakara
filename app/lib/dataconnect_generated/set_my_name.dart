part of 'sahakara.dart';

class SetMyNameVariablesBuilder {
  String name;

  final FirebaseDataConnect _dataConnect;
  SetMyNameVariablesBuilder(this._dataConnect, {required  this.name,});
  Deserializer<SetMyNameData> dataDeserializer = (dynamic json)  => SetMyNameData.fromJson(jsonDecode(json));
  Serializer<SetMyNameVariables> varsSerializer = (SetMyNameVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<SetMyNameData, SetMyNameVariables>> execute() {
    return ref().execute();
  }

  MutationRef<SetMyNameData, SetMyNameVariables> ref() {
    SetMyNameVariables vars= SetMyNameVariables(name: name,);
    return _dataConnect.mutation("SetMyName", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class SetMyNameData {
  final int user_updateMany;
  SetMyNameData.fromJson(dynamic json):
  
  user_updateMany = nativeFromJson<int>(json['user_updateMany']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SetMyNameData otherTyped = other as SetMyNameData;
    return user_updateMany == otherTyped.user_updateMany;
    
  }
  @override
  int get hashCode => user_updateMany.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['user_updateMany'] = nativeToJson<int>(user_updateMany);
    return json;
  }

  SetMyNameData({
    required this.user_updateMany,
  });
}

@immutable
class SetMyNameVariables {
  final String name;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  SetMyNameVariables.fromJson(Map<String, dynamic> json):
  
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SetMyNameVariables otherTyped = other as SetMyNameVariables;
    return name == otherTyped.name;
    
  }
  @override
  int get hashCode => name.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  SetMyNameVariables({
    required this.name,
  });
}

