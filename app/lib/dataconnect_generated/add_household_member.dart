part of 'sahakara.dart';

class AddHouseholdMemberVariablesBuilder {
  String householdId;
  String userId;
  MemberRole role;

  final FirebaseDataConnect _dataConnect;
  AddHouseholdMemberVariablesBuilder(this._dataConnect, {required  this.householdId,required  this.userId,required  this.role,});
  Deserializer<AddHouseholdMemberData> dataDeserializer = (dynamic json)  => AddHouseholdMemberData.fromJson(jsonDecode(json));
  Serializer<AddHouseholdMemberVariables> varsSerializer = (AddHouseholdMemberVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AddHouseholdMemberData, AddHouseholdMemberVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AddHouseholdMemberData, AddHouseholdMemberVariables> ref() {
    AddHouseholdMemberVariables vars= AddHouseholdMemberVariables(householdId: householdId,userId: userId,role: role,);
    return _dataConnect.mutation("AddHouseholdMember", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class AddHouseholdMemberHouseholdMemberInsert {
  final String id;
  AddHouseholdMemberHouseholdMemberInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddHouseholdMemberHouseholdMemberInsert otherTyped = other as AddHouseholdMemberHouseholdMemberInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AddHouseholdMemberHouseholdMemberInsert({
    required this.id,
  });
}

@immutable
class AddHouseholdMemberData {
  final AddHouseholdMemberHouseholdMemberInsert householdMember_insert;
  AddHouseholdMemberData.fromJson(dynamic json):
  
  householdMember_insert = AddHouseholdMemberHouseholdMemberInsert.fromJson(json['householdMember_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddHouseholdMemberData otherTyped = other as AddHouseholdMemberData;
    return householdMember_insert == otherTyped.householdMember_insert;
    
  }
  @override
  int get hashCode => householdMember_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['householdMember_insert'] = householdMember_insert.toJson();
    return json;
  }

  AddHouseholdMemberData({
    required this.householdMember_insert,
  });
}

@immutable
class AddHouseholdMemberVariables {
  final String householdId;
  final String userId;
  final MemberRole role;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AddHouseholdMemberVariables.fromJson(Map<String, dynamic> json):
  
  householdId = nativeFromJson<String>(json['householdId']),
  userId = nativeFromJson<String>(json['userId']),
  role = MemberRole.values.byName(json['role']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddHouseholdMemberVariables otherTyped = other as AddHouseholdMemberVariables;
    return householdId == otherTyped.householdId && 
    userId == otherTyped.userId && 
    role == otherTyped.role;
    
  }
  @override
  int get hashCode => Object.hashAll([householdId.hashCode, userId.hashCode, role.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['householdId'] = nativeToJson<String>(householdId);
    json['userId'] = nativeToJson<String>(userId);
    json['role'] = 
    role.name
    ;
    return json;
  }

  AddHouseholdMemberVariables({
    required this.householdId,
    required this.userId,
    required this.role,
  });
}

