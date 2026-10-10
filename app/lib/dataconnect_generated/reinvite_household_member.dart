part of 'sahakara.dart';

class ReinviteHouseholdMemberVariablesBuilder {
  String householdId;
  String userId;
  MemberRole role;
  PayType payType;
  double rate;
  Optional<double> _allowance = Optional.optional(nativeFromJson, nativeToJson);
  Optional<int> _durationMonths = Optional.optional(nativeFromJson, nativeToJson);
  Optional<int> _durationDays = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _offDays = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _workingHours = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  ReinviteHouseholdMemberVariablesBuilder allowance(double? t) {
   _allowance.value = t;
   return this;
  }
  ReinviteHouseholdMemberVariablesBuilder durationMonths(int? t) {
   _durationMonths.value = t;
   return this;
  }
  ReinviteHouseholdMemberVariablesBuilder durationDays(int? t) {
   _durationDays.value = t;
   return this;
  }
  ReinviteHouseholdMemberVariablesBuilder offDays(String? t) {
   _offDays.value = t;
   return this;
  }
  ReinviteHouseholdMemberVariablesBuilder workingHours(String? t) {
   _workingHours.value = t;
   return this;
  }

  ReinviteHouseholdMemberVariablesBuilder(this._dataConnect, {required  this.householdId,required  this.userId,required  this.role,required  this.payType,required  this.rate,});
  Deserializer<ReinviteHouseholdMemberData> dataDeserializer = (dynamic json)  => ReinviteHouseholdMemberData.fromJson(jsonDecode(json));
  Serializer<ReinviteHouseholdMemberVariables> varsSerializer = (ReinviteHouseholdMemberVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<ReinviteHouseholdMemberData, ReinviteHouseholdMemberVariables>> execute() {
    return ref().execute();
  }

  MutationRef<ReinviteHouseholdMemberData, ReinviteHouseholdMemberVariables> ref() {
    ReinviteHouseholdMemberVariables vars= ReinviteHouseholdMemberVariables(householdId: householdId,userId: userId,role: role,payType: payType,rate: rate,allowance: _allowance,durationMonths: _durationMonths,durationDays: _durationDays,offDays: _offDays,workingHours: _workingHours,);
    return _dataConnect.mutation("ReinviteHouseholdMember", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ReinviteHouseholdMemberContractInsert {
  final String id;
  ReinviteHouseholdMemberContractInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ReinviteHouseholdMemberContractInsert otherTyped = other as ReinviteHouseholdMemberContractInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  ReinviteHouseholdMemberContractInsert({
    required this.id,
  });
}

@immutable
class ReinviteHouseholdMemberData {
  final int householdMember_updateMany;
  final ReinviteHouseholdMemberContractInsert contract_insert;
  ReinviteHouseholdMemberData.fromJson(dynamic json):
  
  householdMember_updateMany = nativeFromJson<int>(json['householdMember_updateMany']),
  contract_insert = ReinviteHouseholdMemberContractInsert.fromJson(json['contract_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ReinviteHouseholdMemberData otherTyped = other as ReinviteHouseholdMemberData;
    return householdMember_updateMany == otherTyped.householdMember_updateMany && 
    contract_insert == otherTyped.contract_insert;
    
  }
  @override
  int get hashCode => Object.hashAll([householdMember_updateMany.hashCode, contract_insert.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['householdMember_updateMany'] = nativeToJson<int>(householdMember_updateMany);
    json['contract_insert'] = contract_insert.toJson();
    return json;
  }

  ReinviteHouseholdMemberData({
    required this.householdMember_updateMany,
    required this.contract_insert,
  });
}

@immutable
class ReinviteHouseholdMemberVariables {
  final String householdId;
  final String userId;
  final MemberRole role;
  final PayType payType;
  final double rate;
  late final Optional<double>allowance;
  late final Optional<int>durationMonths;
  late final Optional<int>durationDays;
  late final Optional<String>offDays;
  late final Optional<String>workingHours;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ReinviteHouseholdMemberVariables.fromJson(Map<String, dynamic> json):
  
  householdId = nativeFromJson<String>(json['householdId']),
  userId = nativeFromJson<String>(json['userId']),
  role = MemberRole.values.byName(json['role']),
  payType = PayType.values.byName(json['payType']),
  rate = nativeFromJson<double>(json['rate']) {
  
  
  
  
  
  
  
    allowance = Optional.optional(nativeFromJson, nativeToJson);
    allowance.value = json['allowance'] == null ? null : nativeFromJson<double>(json['allowance']);
  
  
    durationMonths = Optional.optional(nativeFromJson, nativeToJson);
    durationMonths.value = json['durationMonths'] == null ? null : nativeFromJson<int>(json['durationMonths']);
  
  
    durationDays = Optional.optional(nativeFromJson, nativeToJson);
    durationDays.value = json['durationDays'] == null ? null : nativeFromJson<int>(json['durationDays']);
  
  
    offDays = Optional.optional(nativeFromJson, nativeToJson);
    offDays.value = json['offDays'] == null ? null : nativeFromJson<String>(json['offDays']);
  
  
    workingHours = Optional.optional(nativeFromJson, nativeToJson);
    workingHours.value = json['workingHours'] == null ? null : nativeFromJson<String>(json['workingHours']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ReinviteHouseholdMemberVariables otherTyped = other as ReinviteHouseholdMemberVariables;
    return householdId == otherTyped.householdId && 
    userId == otherTyped.userId && 
    role == otherTyped.role && 
    payType == otherTyped.payType && 
    rate == otherTyped.rate && 
    allowance == otherTyped.allowance && 
    durationMonths == otherTyped.durationMonths && 
    durationDays == otherTyped.durationDays && 
    offDays == otherTyped.offDays && 
    workingHours == otherTyped.workingHours;
    
  }
  @override
  int get hashCode => Object.hashAll([householdId.hashCode, userId.hashCode, role.hashCode, payType.hashCode, rate.hashCode, allowance.hashCode, durationMonths.hashCode, durationDays.hashCode, offDays.hashCode, workingHours.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['householdId'] = nativeToJson<String>(householdId);
    json['userId'] = nativeToJson<String>(userId);
    json['role'] = 
    role.name
    ;
    json['payType'] = 
    payType.name
    ;
    json['rate'] = nativeToJson<double>(rate);
    if(allowance.state == OptionalState.set) {
      json['allowance'] = allowance.toJson();
    }
    if(durationMonths.state == OptionalState.set) {
      json['durationMonths'] = durationMonths.toJson();
    }
    if(durationDays.state == OptionalState.set) {
      json['durationDays'] = durationDays.toJson();
    }
    if(offDays.state == OptionalState.set) {
      json['offDays'] = offDays.toJson();
    }
    if(workingHours.state == OptionalState.set) {
      json['workingHours'] = workingHours.toJson();
    }
    return json;
  }

  ReinviteHouseholdMemberVariables({
    required this.householdId,
    required this.userId,
    required this.role,
    required this.payType,
    required this.rate,
    required this.allowance,
    required this.durationMonths,
    required this.durationDays,
    required this.offDays,
    required this.workingHours,
  });
}

