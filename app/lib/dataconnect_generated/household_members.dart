part of 'sahakara.dart';

class HouseholdMembersVariablesBuilder {
  String householdId;

  final FirebaseDataConnect _dataConnect;
  HouseholdMembersVariablesBuilder(this._dataConnect, {required  this.householdId,});
  Deserializer<HouseholdMembersData> dataDeserializer = (dynamic json)  => HouseholdMembersData.fromJson(jsonDecode(json));
  Serializer<HouseholdMembersVariables> varsSerializer = (HouseholdMembersVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<HouseholdMembersData, HouseholdMembersVariables>> execute() {
    return ref().execute();
  }

  QueryRef<HouseholdMembersData, HouseholdMembersVariables> ref() {
    HouseholdMembersVariables vars= HouseholdMembersVariables(householdId: householdId,);
    return _dataConnect.query("HouseholdMembers", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class HouseholdMembersHouseholdMembers {
  final String id;
  final EnumValue<MemberRole> role;
  final bool active;
  final EnumValue<MembershipStatus> status;
  final HouseholdMembersHouseholdMembersUser user;
  HouseholdMembersHouseholdMembers.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  role = memberRoleDeserializer(json['role']),
  active = nativeFromJson<bool>(json['active']),
  status = membershipStatusDeserializer(json['status']),
  user = HouseholdMembersHouseholdMembersUser.fromJson(json['user']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdMembersHouseholdMembers otherTyped = other as HouseholdMembersHouseholdMembers;
    return id == otherTyped.id && 
    role == otherTyped.role && 
    active == otherTyped.active && 
    status == otherTyped.status && 
    user == otherTyped.user;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, role.hashCode, active.hashCode, status.hashCode, user.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['role'] = 
    memberRoleSerializer(role)
    ;
    json['active'] = nativeToJson<bool>(active);
    json['status'] = 
    membershipStatusSerializer(status)
    ;
    json['user'] = user.toJson();
    return json;
  }

  HouseholdMembersHouseholdMembers({
    required this.id,
    required this.role,
    required this.active,
    required this.status,
    required this.user,
  });
}

@immutable
class HouseholdMembersHouseholdMembersUser {
  final String id;
  final String name;
  final String email;
  HouseholdMembersHouseholdMembersUser.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  email = nativeFromJson<String>(json['email']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdMembersHouseholdMembersUser otherTyped = other as HouseholdMembersHouseholdMembersUser;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    email == otherTyped.email;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, email.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['email'] = nativeToJson<String>(email);
    return json;
  }

  HouseholdMembersHouseholdMembersUser({
    required this.id,
    required this.name,
    required this.email,
  });
}

@immutable
class HouseholdMembersData {
  final List<HouseholdMembersHouseholdMembers> householdMembers;
  HouseholdMembersData.fromJson(dynamic json):
  
  householdMembers = (json['householdMembers'] as List<dynamic>)
        .map((e) => HouseholdMembersHouseholdMembers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdMembersData otherTyped = other as HouseholdMembersData;
    return householdMembers == otherTyped.householdMembers;
    
  }
  @override
  int get hashCode => householdMembers.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['householdMembers'] = householdMembers.map((e) => e.toJson()).toList();
    return json;
  }

  HouseholdMembersData({
    required this.householdMembers,
  });
}

@immutable
class HouseholdMembersVariables {
  final String householdId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  HouseholdMembersVariables.fromJson(Map<String, dynamic> json):
  
  householdId = nativeFromJson<String>(json['householdId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdMembersVariables otherTyped = other as HouseholdMembersVariables;
    return householdId == otherTyped.householdId;
    
  }
  @override
  int get hashCode => householdId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['householdId'] = nativeToJson<String>(householdId);
    return json;
  }

  HouseholdMembersVariables({
    required this.householdId,
  });
}

