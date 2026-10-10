part of 'sahakara.dart';

class PendingMyMembershipVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  PendingMyMembershipVariablesBuilder(this._dataConnect, );
  Deserializer<PendingMyMembershipData> dataDeserializer = (dynamic json)  => PendingMyMembershipData.fromJson(jsonDecode(json));
  
  Future<QueryResult<PendingMyMembershipData, void>> execute() {
    return ref().execute();
  }

  QueryRef<PendingMyMembershipData, void> ref() {
    
    return _dataConnect.query("PendingMyMembership", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class PendingMyMembershipHouseholdMembers {
  final String id;
  final EnumValue<MemberRole> role;
  final PendingMyMembershipHouseholdMembersHousehold household;
  PendingMyMembershipHouseholdMembers.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  role = memberRoleDeserializer(json['role']),
  household = PendingMyMembershipHouseholdMembersHousehold.fromJson(json['household']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final PendingMyMembershipHouseholdMembers otherTyped = other as PendingMyMembershipHouseholdMembers;
    return id == otherTyped.id && 
    role == otherTyped.role && 
    household == otherTyped.household;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, role.hashCode, household.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['role'] = 
    memberRoleSerializer(role)
    ;
    json['household'] = household.toJson();
    return json;
  }

  PendingMyMembershipHouseholdMembers({
    required this.id,
    required this.role,
    required this.household,
  });
}

@immutable
class PendingMyMembershipHouseholdMembersHousehold {
  final String id;
  final String name;
  final String? address;
  final String? area;
  PendingMyMembershipHouseholdMembersHousehold.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  address = json['address'] == null ? null : nativeFromJson<String>(json['address']),
  area = json['area'] == null ? null : nativeFromJson<String>(json['area']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final PendingMyMembershipHouseholdMembersHousehold otherTyped = other as PendingMyMembershipHouseholdMembersHousehold;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    address == otherTyped.address && 
    area == otherTyped.area;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, address.hashCode, area.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    if (address != null) {
      json['address'] = nativeToJson<String?>(address);
    }
    if (area != null) {
      json['area'] = nativeToJson<String?>(area);
    }
    return json;
  }

  PendingMyMembershipHouseholdMembersHousehold({
    required this.id,
    required this.name,
    this.address,
    this.area,
  });
}

@immutable
class PendingMyMembershipData {
  final List<PendingMyMembershipHouseholdMembers> householdMembers;
  PendingMyMembershipData.fromJson(dynamic json):
  
  householdMembers = (json['householdMembers'] as List<dynamic>)
        .map((e) => PendingMyMembershipHouseholdMembers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final PendingMyMembershipData otherTyped = other as PendingMyMembershipData;
    return householdMembers == otherTyped.householdMembers;
    
  }
  @override
  int get hashCode => householdMembers.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['householdMembers'] = householdMembers.map((e) => e.toJson()).toList();
    return json;
  }

  PendingMyMembershipData({
    required this.householdMembers,
  });
}

