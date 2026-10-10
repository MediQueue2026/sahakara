part of 'sahakara.dart';

class MyHouseholdInvitesVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  MyHouseholdInvitesVariablesBuilder(this._dataConnect, );
  Deserializer<MyHouseholdInvitesData> dataDeserializer = (dynamic json)  => MyHouseholdInvitesData.fromJson(jsonDecode(json));
  
  Future<QueryResult<MyHouseholdInvitesData, void>> execute() {
    return ref().execute();
  }

  QueryRef<MyHouseholdInvitesData, void> ref() {
    
    return _dataConnect.query("MyHouseholdInvites", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class MyHouseholdInvitesHouseholdMembers {
  final String id;
  final EnumValue<MemberRole> role;
  final bool active;
  final EnumValue<MembershipStatus> status;
  final MyHouseholdInvitesHouseholdMembersHousehold household;
  final List<MyHouseholdInvitesHouseholdMembersContractsOnMember> contracts_on_member;
  MyHouseholdInvitesHouseholdMembers.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  role = memberRoleDeserializer(json['role']),
  active = nativeFromJson<bool>(json['active']),
  status = membershipStatusDeserializer(json['status']),
  household = MyHouseholdInvitesHouseholdMembersHousehold.fromJson(json['household']),
  contracts_on_member = (json['contracts_on_member'] as List<dynamic>)
        .map((e) => MyHouseholdInvitesHouseholdMembersContractsOnMember.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MyHouseholdInvitesHouseholdMembers otherTyped = other as MyHouseholdInvitesHouseholdMembers;
    return id == otherTyped.id && 
    role == otherTyped.role && 
    active == otherTyped.active && 
    status == otherTyped.status && 
    household == otherTyped.household && 
    contracts_on_member == otherTyped.contracts_on_member;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, role.hashCode, active.hashCode, status.hashCode, household.hashCode, contracts_on_member.hashCode]);
  

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
    json['household'] = household.toJson();
    json['contracts_on_member'] = contracts_on_member.map((e) => e.toJson()).toList();
    return json;
  }

  MyHouseholdInvitesHouseholdMembers({
    required this.id,
    required this.role,
    required this.active,
    required this.status,
    required this.household,
    required this.contracts_on_member,
  });
}

@immutable
class MyHouseholdInvitesHouseholdMembersHousehold {
  final String name;
  final String? area;
  final MyHouseholdInvitesHouseholdMembersHouseholdOwner owner;
  MyHouseholdInvitesHouseholdMembersHousehold.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']),
  area = json['area'] == null ? null : nativeFromJson<String>(json['area']),
  owner = MyHouseholdInvitesHouseholdMembersHouseholdOwner.fromJson(json['owner']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MyHouseholdInvitesHouseholdMembersHousehold otherTyped = other as MyHouseholdInvitesHouseholdMembersHousehold;
    return name == otherTyped.name && 
    area == otherTyped.area && 
    owner == otherTyped.owner;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, area.hashCode, owner.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    if (area != null) {
      json['area'] = nativeToJson<String?>(area);
    }
    json['owner'] = owner.toJson();
    return json;
  }

  MyHouseholdInvitesHouseholdMembersHousehold({
    required this.name,
    this.area,
    required this.owner,
  });
}

@immutable
class MyHouseholdInvitesHouseholdMembersHouseholdOwner {
  final String name;
  final List<EnumValue<AppLanguage>>? spokenLanguages;
  MyHouseholdInvitesHouseholdMembersHouseholdOwner.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']),
  spokenLanguages = json['spokenLanguages'] == null ? null : (json['spokenLanguages'] as List<dynamic>)
        .map((e) => appLanguageDeserializer(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MyHouseholdInvitesHouseholdMembersHouseholdOwner otherTyped = other as MyHouseholdInvitesHouseholdMembersHouseholdOwner;
    return name == otherTyped.name && 
    spokenLanguages == otherTyped.spokenLanguages;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, spokenLanguages.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    if (spokenLanguages != null) {
      json['spokenLanguages'] = spokenLanguages?.map((e) => appLanguageSerializer(e)).toList();
    }
    return json;
  }

  MyHouseholdInvitesHouseholdMembersHouseholdOwner({
    required this.name,
    this.spokenLanguages,
  });
}

@immutable
class MyHouseholdInvitesHouseholdMembersContractsOnMember {
  final EnumValue<PayType> payType;
  final double rate;
  final double? allowance;
  final int? durationMonths;
  final int? durationDays;
  final String? offDays;
  final String? workingHours;
  MyHouseholdInvitesHouseholdMembersContractsOnMember.fromJson(dynamic json):
  
  payType = payTypeDeserializer(json['payType']),
  rate = nativeFromJson<double>(json['rate']),
  allowance = json['allowance'] == null ? null : nativeFromJson<double>(json['allowance']),
  durationMonths = json['durationMonths'] == null ? null : nativeFromJson<int>(json['durationMonths']),
  durationDays = json['durationDays'] == null ? null : nativeFromJson<int>(json['durationDays']),
  offDays = json['offDays'] == null ? null : nativeFromJson<String>(json['offDays']),
  workingHours = json['workingHours'] == null ? null : nativeFromJson<String>(json['workingHours']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MyHouseholdInvitesHouseholdMembersContractsOnMember otherTyped = other as MyHouseholdInvitesHouseholdMembersContractsOnMember;
    return payType == otherTyped.payType && 
    rate == otherTyped.rate && 
    allowance == otherTyped.allowance && 
    durationMonths == otherTyped.durationMonths && 
    durationDays == otherTyped.durationDays && 
    offDays == otherTyped.offDays && 
    workingHours == otherTyped.workingHours;
    
  }
  @override
  int get hashCode => Object.hashAll([payType.hashCode, rate.hashCode, allowance.hashCode, durationMonths.hashCode, durationDays.hashCode, offDays.hashCode, workingHours.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['payType'] = 
    payTypeSerializer(payType)
    ;
    json['rate'] = nativeToJson<double>(rate);
    if (allowance != null) {
      json['allowance'] = nativeToJson<double?>(allowance);
    }
    if (durationMonths != null) {
      json['durationMonths'] = nativeToJson<int?>(durationMonths);
    }
    if (durationDays != null) {
      json['durationDays'] = nativeToJson<int?>(durationDays);
    }
    if (offDays != null) {
      json['offDays'] = nativeToJson<String?>(offDays);
    }
    if (workingHours != null) {
      json['workingHours'] = nativeToJson<String?>(workingHours);
    }
    return json;
  }

  MyHouseholdInvitesHouseholdMembersContractsOnMember({
    required this.payType,
    required this.rate,
    this.allowance,
    this.durationMonths,
    this.durationDays,
    this.offDays,
    this.workingHours,
  });
}

@immutable
class MyHouseholdInvitesData {
  final List<MyHouseholdInvitesHouseholdMembers> householdMembers;
  MyHouseholdInvitesData.fromJson(dynamic json):
  
  householdMembers = (json['householdMembers'] as List<dynamic>)
        .map((e) => MyHouseholdInvitesHouseholdMembers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MyHouseholdInvitesData otherTyped = other as MyHouseholdInvitesData;
    return householdMembers == otherTyped.householdMembers;
    
  }
  @override
  int get hashCode => householdMembers.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['householdMembers'] = householdMembers.map((e) => e.toJson()).toList();
    return json;
  }

  MyHouseholdInvitesData({
    required this.householdMembers,
  });
}

