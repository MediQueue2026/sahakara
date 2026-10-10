part of 'sahakara.dart';

class MyMembershipByIdVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  MyMembershipByIdVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<MyMembershipByIdData> dataDeserializer = (dynamic json)  => MyMembershipByIdData.fromJson(jsonDecode(json));
  Serializer<MyMembershipByIdVariables> varsSerializer = (MyMembershipByIdVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<MyMembershipByIdData, MyMembershipByIdVariables>> execute() {
    return ref().execute();
  }

  QueryRef<MyMembershipByIdData, MyMembershipByIdVariables> ref() {
    MyMembershipByIdVariables vars= MyMembershipByIdVariables(id: id,);
    return _dataConnect.query("MyMembershipById", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class MyMembershipByIdHouseholdMembers {
  final String id;
  final EnumValue<MemberRole> role;
  final MyMembershipByIdHouseholdMembersHousehold household;
  MyMembershipByIdHouseholdMembers.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  role = memberRoleDeserializer(json['role']),
  household = MyMembershipByIdHouseholdMembersHousehold.fromJson(json['household']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MyMembershipByIdHouseholdMembers otherTyped = other as MyMembershipByIdHouseholdMembers;
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

  MyMembershipByIdHouseholdMembers({
    required this.id,
    required this.role,
    required this.household,
  });
}

@immutable
class MyMembershipByIdHouseholdMembersHousehold {
  final String id;
  final String name;
  final String? address;
  final String? area;
  MyMembershipByIdHouseholdMembersHousehold.fromJson(dynamic json):
  
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

    final MyMembershipByIdHouseholdMembersHousehold otherTyped = other as MyMembershipByIdHouseholdMembersHousehold;
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

  MyMembershipByIdHouseholdMembersHousehold({
    required this.id,
    required this.name,
    this.address,
    this.area,
  });
}

@immutable
class MyMembershipByIdData {
  final List<MyMembershipByIdHouseholdMembers> householdMembers;
  MyMembershipByIdData.fromJson(dynamic json):
  
  householdMembers = (json['householdMembers'] as List<dynamic>)
        .map((e) => MyMembershipByIdHouseholdMembers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MyMembershipByIdData otherTyped = other as MyMembershipByIdData;
    return householdMembers == otherTyped.householdMembers;
    
  }
  @override
  int get hashCode => householdMembers.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['householdMembers'] = householdMembers.map((e) => e.toJson()).toList();
    return json;
  }

  MyMembershipByIdData({
    required this.householdMembers,
  });
}

@immutable
class MyMembershipByIdVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  MyMembershipByIdVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MyMembershipByIdVariables otherTyped = other as MyMembershipByIdVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  MyMembershipByIdVariables({
    required this.id,
  });
}

