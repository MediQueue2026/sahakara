part of 'sahakara.dart';

class CancelHouseholdInviteVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  CancelHouseholdInviteVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<CancelHouseholdInviteData> dataDeserializer = (dynamic json)  => CancelHouseholdInviteData.fromJson(jsonDecode(json));
  Serializer<CancelHouseholdInviteVariables> varsSerializer = (CancelHouseholdInviteVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CancelHouseholdInviteData, CancelHouseholdInviteVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CancelHouseholdInviteData, CancelHouseholdInviteVariables> ref() {
    CancelHouseholdInviteVariables vars= CancelHouseholdInviteVariables(id: id,);
    return _dataConnect.mutation("CancelHouseholdInvite", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CancelHouseholdInviteHouseholdMemberDelete {
  final String id;
  CancelHouseholdInviteHouseholdMemberDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CancelHouseholdInviteHouseholdMemberDelete otherTyped = other as CancelHouseholdInviteHouseholdMemberDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CancelHouseholdInviteHouseholdMemberDelete({
    required this.id,
  });
}

@immutable
class CancelHouseholdInviteData {
  final int contract_deleteMany;
  final CancelHouseholdInviteHouseholdMemberDelete? householdMember_delete;
  CancelHouseholdInviteData.fromJson(dynamic json):
  
  contract_deleteMany = nativeFromJson<int>(json['contract_deleteMany']),
  householdMember_delete = json['householdMember_delete'] == null ? null : CancelHouseholdInviteHouseholdMemberDelete.fromJson(json['householdMember_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CancelHouseholdInviteData otherTyped = other as CancelHouseholdInviteData;
    return contract_deleteMany == otherTyped.contract_deleteMany && 
    householdMember_delete == otherTyped.householdMember_delete;
    
  }
  @override
  int get hashCode => Object.hashAll([contract_deleteMany.hashCode, householdMember_delete.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['contract_deleteMany'] = nativeToJson<int>(contract_deleteMany);
    if (householdMember_delete != null) {
      json['householdMember_delete'] = householdMember_delete!.toJson();
    }
    return json;
  }

  CancelHouseholdInviteData({
    required this.contract_deleteMany,
    this.householdMember_delete,
  });
}

@immutable
class CancelHouseholdInviteVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CancelHouseholdInviteVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CancelHouseholdInviteVariables otherTyped = other as CancelHouseholdInviteVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CancelHouseholdInviteVariables({
    required this.id,
  });
}

