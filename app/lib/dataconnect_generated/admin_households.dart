part of 'sahakara.dart';

class AdminHouseholdsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  AdminHouseholdsVariablesBuilder(this._dataConnect, );
  Deserializer<AdminHouseholdsData> dataDeserializer = (dynamic json)  => AdminHouseholdsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<AdminHouseholdsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<AdminHouseholdsData, void> ref() {
    
    return _dataConnect.query("AdminHouseholds", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class AdminHouseholdsHouseholds {
  final String id;
  final String name;
  final String? address;
  final Timestamp createdAt;
  final List<AdminHouseholdsHouseholdsHouseholdMembersOnHousehold> householdMembers_on_household;
  AdminHouseholdsHouseholds.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  address = json['address'] == null ? null : nativeFromJson<String>(json['address']),
  createdAt = Timestamp.fromJson(json['createdAt']),
  householdMembers_on_household = (json['householdMembers_on_household'] as List<dynamic>)
        .map((e) => AdminHouseholdsHouseholdsHouseholdMembersOnHousehold.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AdminHouseholdsHouseholds otherTyped = other as AdminHouseholdsHouseholds;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    address == otherTyped.address && 
    createdAt == otherTyped.createdAt && 
    householdMembers_on_household == otherTyped.householdMembers_on_household;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, address.hashCode, createdAt.hashCode, householdMembers_on_household.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    if (address != null) {
      json['address'] = nativeToJson<String?>(address);
    }
    json['createdAt'] = createdAt.toJson();
    json['householdMembers_on_household'] = householdMembers_on_household.map((e) => e.toJson()).toList();
    return json;
  }

  AdminHouseholdsHouseholds({
    required this.id,
    required this.name,
    this.address,
    required this.createdAt,
    required this.householdMembers_on_household,
  });
}

@immutable
class AdminHouseholdsHouseholdsHouseholdMembersOnHousehold {
  final String id;
  AdminHouseholdsHouseholdsHouseholdMembersOnHousehold.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AdminHouseholdsHouseholdsHouseholdMembersOnHousehold otherTyped = other as AdminHouseholdsHouseholdsHouseholdMembersOnHousehold;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AdminHouseholdsHouseholdsHouseholdMembersOnHousehold({
    required this.id,
  });
}

@immutable
class AdminHouseholdsData {
  final List<AdminHouseholdsHouseholds> households;
  AdminHouseholdsData.fromJson(dynamic json):
  
  households = (json['households'] as List<dynamic>)
        .map((e) => AdminHouseholdsHouseholds.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AdminHouseholdsData otherTyped = other as AdminHouseholdsData;
    return households == otherTyped.households;
    
  }
  @override
  int get hashCode => households.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['households'] = households.map((e) => e.toJson()).toList();
    return json;
  }

  AdminHouseholdsData({
    required this.households,
  });
}

