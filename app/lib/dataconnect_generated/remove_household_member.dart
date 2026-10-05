part of 'sahakara.dart';

class RemoveHouseholdMemberVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  RemoveHouseholdMemberVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<RemoveHouseholdMemberData> dataDeserializer = (dynamic json)  => RemoveHouseholdMemberData.fromJson(jsonDecode(json));
  Serializer<RemoveHouseholdMemberVariables> varsSerializer = (RemoveHouseholdMemberVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<RemoveHouseholdMemberData, RemoveHouseholdMemberVariables>> execute() {
    return ref().execute();
  }

  MutationRef<RemoveHouseholdMemberData, RemoveHouseholdMemberVariables> ref() {
    RemoveHouseholdMemberVariables vars= RemoveHouseholdMemberVariables(id: id,);
    return _dataConnect.mutation("RemoveHouseholdMember", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class RemoveHouseholdMemberHouseholdMemberUpdate {
  final String id;
  RemoveHouseholdMemberHouseholdMemberUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RemoveHouseholdMemberHouseholdMemberUpdate otherTyped = other as RemoveHouseholdMemberHouseholdMemberUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  RemoveHouseholdMemberHouseholdMemberUpdate({
    required this.id,
  });
}

@immutable
class RemoveHouseholdMemberData {
  final RemoveHouseholdMemberHouseholdMemberUpdate? householdMember_update;
  final int contract_updateMany;
  final int task_updateMany;
  RemoveHouseholdMemberData.fromJson(dynamic json):
  
  householdMember_update = json['householdMember_update'] == null ? null : RemoveHouseholdMemberHouseholdMemberUpdate.fromJson(json['householdMember_update']),
  contract_updateMany = nativeFromJson<int>(json['contract_updateMany']),
  task_updateMany = nativeFromJson<int>(json['task_updateMany']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RemoveHouseholdMemberData otherTyped = other as RemoveHouseholdMemberData;
    return householdMember_update == otherTyped.householdMember_update && 
    contract_updateMany == otherTyped.contract_updateMany && 
    task_updateMany == otherTyped.task_updateMany;
    
  }
  @override
  int get hashCode => Object.hashAll([householdMember_update.hashCode, contract_updateMany.hashCode, task_updateMany.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (householdMember_update != null) {
      json['householdMember_update'] = householdMember_update!.toJson();
    }
    json['contract_updateMany'] = nativeToJson<int>(contract_updateMany);
    json['task_updateMany'] = nativeToJson<int>(task_updateMany);
    return json;
  }

  RemoveHouseholdMemberData({
    this.householdMember_update,
    required this.contract_updateMany,
    required this.task_updateMany,
  });
}

@immutable
class RemoveHouseholdMemberVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  RemoveHouseholdMemberVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RemoveHouseholdMemberVariables otherTyped = other as RemoveHouseholdMemberVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  RemoveHouseholdMemberVariables({
    required this.id,
  });
}

