part of 'sahakara.dart';

class AddHouseholdMemberVariablesBuilder {
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

  final FirebaseDataConnect _dataConnect;  AddHouseholdMemberVariablesBuilder allowance(double? t) {
   _allowance.value = t;
   return this;
  }
  AddHouseholdMemberVariablesBuilder durationMonths(int? t) {
   _durationMonths.value = t;
   return this;
  }
  AddHouseholdMemberVariablesBuilder durationDays(int? t) {
   _durationDays.value = t;
   return this;
  }
  AddHouseholdMemberVariablesBuilder offDays(String? t) {
   _offDays.value = t;
   return this;
  }
  AddHouseholdMemberVariablesBuilder workingHours(String? t) {
   _workingHours.value = t;
   return this;
  }

  AddHouseholdMemberVariablesBuilder(this._dataConnect, {required  this.householdId,required  this.userId,required  this.role,required  this.payType,required  this.rate,});
  Deserializer<AddHouseholdMemberData> dataDeserializer = (dynamic json)  => AddHouseholdMemberData.fromJson(jsonDecode(json));
  Serializer<AddHouseholdMemberVariables> varsSerializer = (AddHouseholdMemberVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AddHouseholdMemberData, AddHouseholdMemberVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AddHouseholdMemberData, AddHouseholdMemberVariables> ref() {
    AddHouseholdMemberVariables vars= AddHouseholdMemberVariables(householdId: householdId,userId: userId,role: role,payType: payType,rate: rate,allowance: _allowance,durationMonths: _durationMonths,durationDays: _durationDays,offDays: _offDays,workingHours: _workingHours,);
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
class AddHouseholdMemberContractInsert {
  final String id;
  AddHouseholdMemberContractInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddHouseholdMemberContractInsert otherTyped = other as AddHouseholdMemberContractInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AddHouseholdMemberContractInsert({
    required this.id,
  });
}

@immutable
class AddHouseholdMemberData {
  final AddHouseholdMemberHouseholdMemberInsert householdMember_insert;
  final AddHouseholdMemberContractInsert contract_insert;
  AddHouseholdMemberData.fromJson(dynamic json):
  
  householdMember_insert = AddHouseholdMemberHouseholdMemberInsert.fromJson(json['householdMember_insert']),
  contract_insert = AddHouseholdMemberContractInsert.fromJson(json['contract_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddHouseholdMemberData otherTyped = other as AddHouseholdMemberData;
    return householdMember_insert == otherTyped.householdMember_insert && 
    contract_insert == otherTyped.contract_insert;
    
  }
  @override
  int get hashCode => Object.hashAll([householdMember_insert.hashCode, contract_insert.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['householdMember_insert'] = householdMember_insert.toJson();
    json['contract_insert'] = contract_insert.toJson();
    return json;
  }

  AddHouseholdMemberData({
    required this.householdMember_insert,
    required this.contract_insert,
  });
}

@immutable
class AddHouseholdMemberVariables {
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
  AddHouseholdMemberVariables.fromJson(Map<String, dynamic> json):
  
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

    final AddHouseholdMemberVariables otherTyped = other as AddHouseholdMemberVariables;
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

  AddHouseholdMemberVariables({
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

