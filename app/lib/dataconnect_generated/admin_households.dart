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
  final AdminHouseholdsHouseholdsHouseholdSubscriptionOnHousehold? householdSubscription_on_household;
  AdminHouseholdsHouseholds.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  address = json['address'] == null ? null : nativeFromJson<String>(json['address']),
  createdAt = Timestamp.fromJson(json['createdAt']),
  householdMembers_on_household = (json['householdMembers_on_household'] as List<dynamic>)
        .map((e) => AdminHouseholdsHouseholdsHouseholdMembersOnHousehold.fromJson(e))
        .toList(),
  householdSubscription_on_household = json['householdSubscription_on_household'] == null ? null : AdminHouseholdsHouseholdsHouseholdSubscriptionOnHousehold.fromJson(json['householdSubscription_on_household']);
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
    householdMembers_on_household == otherTyped.householdMembers_on_household && 
    householdSubscription_on_household == otherTyped.householdSubscription_on_household;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, address.hashCode, createdAt.hashCode, householdMembers_on_household.hashCode, householdSubscription_on_household.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    if (address != null) {
      json['address'] = nativeToJson<String?>(address);
    }
    json['createdAt'] = createdAt.toJson();
    json['householdMembers_on_household'] = householdMembers_on_household.map((e) => e.toJson()).toList();
    if (householdSubscription_on_household != null) {
      json['householdSubscription_on_household'] = householdSubscription_on_household!.toJson();
    }
    return json;
  }

  AdminHouseholdsHouseholds({
    required this.id,
    required this.name,
    this.address,
    required this.createdAt,
    required this.householdMembers_on_household,
    this.householdSubscription_on_household,
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
class AdminHouseholdsHouseholdsHouseholdSubscriptionOnHousehold {
  final double price;
  final DateTime? paidUntil;
  final AdminHouseholdsHouseholdsHouseholdSubscriptionOnHouseholdPlan plan;
  AdminHouseholdsHouseholdsHouseholdSubscriptionOnHousehold.fromJson(dynamic json):
  
  price = nativeFromJson<double>(json['price']),
  paidUntil = json['paidUntil'] == null ? null : nativeFromJson<DateTime>(json['paidUntil']),
  plan = AdminHouseholdsHouseholdsHouseholdSubscriptionOnHouseholdPlan.fromJson(json['plan']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AdminHouseholdsHouseholdsHouseholdSubscriptionOnHousehold otherTyped = other as AdminHouseholdsHouseholdsHouseholdSubscriptionOnHousehold;
    return price == otherTyped.price && 
    paidUntil == otherTyped.paidUntil && 
    plan == otherTyped.plan;
    
  }
  @override
  int get hashCode => Object.hashAll([price.hashCode, paidUntil.hashCode, plan.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['price'] = nativeToJson<double>(price);
    if (paidUntil != null) {
      json['paidUntil'] = nativeToJson<DateTime?>(paidUntil);
    }
    json['plan'] = plan.toJson();
    return json;
  }

  AdminHouseholdsHouseholdsHouseholdSubscriptionOnHousehold({
    required this.price,
    this.paidUntil,
    required this.plan,
  });
}

@immutable
class AdminHouseholdsHouseholdsHouseholdSubscriptionOnHouseholdPlan {
  final String id;
  final String name;
  final EnumValue<BillingPeriod> billingPeriod;
  AdminHouseholdsHouseholdsHouseholdSubscriptionOnHouseholdPlan.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  billingPeriod = billingPeriodDeserializer(json['billingPeriod']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AdminHouseholdsHouseholdsHouseholdSubscriptionOnHouseholdPlan otherTyped = other as AdminHouseholdsHouseholdsHouseholdSubscriptionOnHouseholdPlan;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    billingPeriod == otherTyped.billingPeriod;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, billingPeriod.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['billingPeriod'] = 
    billingPeriodSerializer(billingPeriod)
    ;
    return json;
  }

  AdminHouseholdsHouseholdsHouseholdSubscriptionOnHouseholdPlan({
    required this.id,
    required this.name,
    required this.billingPeriod,
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

