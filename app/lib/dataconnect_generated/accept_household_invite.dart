part of 'sahakara.dart';

class AcceptHouseholdInviteVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  AcceptHouseholdInviteVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<AcceptHouseholdInviteData> dataDeserializer = (dynamic json)  => AcceptHouseholdInviteData.fromJson(jsonDecode(json));
  Serializer<AcceptHouseholdInviteVariables> varsSerializer = (AcceptHouseholdInviteVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AcceptHouseholdInviteData, AcceptHouseholdInviteVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AcceptHouseholdInviteData, AcceptHouseholdInviteVariables> ref() {
    AcceptHouseholdInviteVariables vars= AcceptHouseholdInviteVariables(id: id,);
    return _dataConnect.mutation("AcceptHouseholdInvite", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class AcceptHouseholdInviteHouseholdMemberUpdate {
  final String id;
  AcceptHouseholdInviteHouseholdMemberUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AcceptHouseholdInviteHouseholdMemberUpdate otherTyped = other as AcceptHouseholdInviteHouseholdMemberUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AcceptHouseholdInviteHouseholdMemberUpdate({
    required this.id,
  });
}

@immutable
class AcceptHouseholdInviteData {
  final AcceptHouseholdInviteHouseholdMemberUpdate? householdMember_update;
  final int contract_updateMany;
  AcceptHouseholdInviteData.fromJson(dynamic json):
  
  householdMember_update = json['householdMember_update'] == null ? null : AcceptHouseholdInviteHouseholdMemberUpdate.fromJson(json['householdMember_update']),
  contract_updateMany = nativeFromJson<int>(json['contract_updateMany']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AcceptHouseholdInviteData otherTyped = other as AcceptHouseholdInviteData;
    return householdMember_update == otherTyped.householdMember_update && 
    contract_updateMany == otherTyped.contract_updateMany;
    
  }
  @override
  int get hashCode => Object.hashAll([householdMember_update.hashCode, contract_updateMany.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (householdMember_update != null) {
      json['householdMember_update'] = householdMember_update!.toJson();
    }
    json['contract_updateMany'] = nativeToJson<int>(contract_updateMany);
    return json;
  }

  AcceptHouseholdInviteData({
    this.householdMember_update,
    required this.contract_updateMany,
  });
}

@immutable
class AcceptHouseholdInviteVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AcceptHouseholdInviteVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AcceptHouseholdInviteVariables otherTyped = other as AcceptHouseholdInviteVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AcceptHouseholdInviteVariables({
    required this.id,
  });
}

