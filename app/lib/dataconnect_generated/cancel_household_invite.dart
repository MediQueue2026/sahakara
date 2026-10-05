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
class CancelHouseholdInviteData {
  final int contract_deleteMany;
  final int householdMember_deleteMany;
  final int householdMember_updateMany;
  CancelHouseholdInviteData.fromJson(dynamic json):
  
  contract_deleteMany = nativeFromJson<int>(json['contract_deleteMany']),
  householdMember_deleteMany = nativeFromJson<int>(json['householdMember_deleteMany']),
  householdMember_updateMany = nativeFromJson<int>(json['householdMember_updateMany']);
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
    householdMember_deleteMany == otherTyped.householdMember_deleteMany && 
    householdMember_updateMany == otherTyped.householdMember_updateMany;
    
  }
  @override
  int get hashCode => Object.hashAll([contract_deleteMany.hashCode, householdMember_deleteMany.hashCode, householdMember_updateMany.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['contract_deleteMany'] = nativeToJson<int>(contract_deleteMany);
    json['householdMember_deleteMany'] = nativeToJson<int>(householdMember_deleteMany);
    json['householdMember_updateMany'] = nativeToJson<int>(householdMember_updateMany);
    return json;
  }

  CancelHouseholdInviteData({
    required this.contract_deleteMany,
    required this.householdMember_deleteMany,
    required this.householdMember_updateMany,
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

