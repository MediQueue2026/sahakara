part of 'sahakara.dart';

class MyMembershipVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  MyMembershipVariablesBuilder(this._dataConnect, );
  Deserializer<MyMembershipData> dataDeserializer = (dynamic json)  => MyMembershipData.fromJson(jsonDecode(json));
  
  Future<QueryResult<MyMembershipData, void>> execute() {
    return ref().execute();
  }

  QueryRef<MyMembershipData, void> ref() {
    
    return _dataConnect.query("MyMembership", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class MyMembershipHouseholdMembers {
  final String id;
  final EnumValue<MemberRole> role;
  final MyMembershipHouseholdMembersHousehold household;
  MyMembershipHouseholdMembers.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  role = memberRoleDeserializer(json['role']),
  household = MyMembershipHouseholdMembersHousehold.fromJson(json['household']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MyMembershipHouseholdMembers otherTyped = other as MyMembershipHouseholdMembers;
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

  MyMembershipHouseholdMembers({
    required this.id,
    required this.role,
    required this.household,
  });
}

@immutable
class MyMembershipHouseholdMembersHousehold {
  final String id;
  final String name;
  final String? address;
  final String? area;
  MyMembershipHouseholdMembersHousehold.fromJson(dynamic json):
  
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

    final MyMembershipHouseholdMembersHousehold otherTyped = other as MyMembershipHouseholdMembersHousehold;
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

  MyMembershipHouseholdMembersHousehold({
    required this.id,
    required this.name,
    this.address,
    this.area,
  });
}

@immutable
class MyMembershipData {
  final List<MyMembershipHouseholdMembers> householdMembers;
  MyMembershipData.fromJson(dynamic json):
  
  householdMembers = (json['householdMembers'] as List<dynamic>)
        .map((e) => MyMembershipHouseholdMembers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MyMembershipData otherTyped = other as MyMembershipData;
    return householdMembers == otherTyped.householdMembers;
    
  }
  @override
  int get hashCode => householdMembers.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['householdMembers'] = householdMembers.map((e) => e.toJson()).toList();
    return json;
  }

  MyMembershipData({
    required this.householdMembers,
  });
}

